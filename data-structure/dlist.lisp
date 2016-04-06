;;; $Id: dlist.lisp,v 1.3 2011/08/06 09:06:03 mmondor Exp $

#|

Copyright (c) 2011, Matthew Mondor
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY MATTHEW MONDOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL MATTHEW MONDOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

|#

;;; dlist.lisp - A doubly-linked list implementation for Common Lisp


(declaim (optimize (speed 3) (safety 0) (debug 1)))

(defpackage :dlist
  (:use :cl)
  (:export #:dlist
	   #:dlist-p
	   #:dlist-first
	   #:dlist-last
	   #:dlist-nodes
	   #:dnode
	   #:dnode-p
	   #:dnode-object
	   #:dnode-prev
	   #:dnode-next
	   #:dnode-alloc
	   #:dnode-free
	   #:with-dnode
	   #:with-dlist
	   #:do-dlist
	   #:map-dlist
	   #:list<-dlist
	   #:dlist<-list
	   #:dlist-reset
	   #:dlist-destroy
	   #:dlist-append
	   #:dlist-insert
	   #:dlist-unlink
	   #:dlist-insert-before
	   #:dlist-swap
	   #:make-dlist))

(in-package :dlist)


(defstruct
    (dnode
      (:constructor %make-dnode ())
      (:print-object
       (lambda (o stream)
	 (print-unreadable-object (o stream :type t :identity t)
	   (princ `(:object ,(dnode-object o)) stream)))))
  "A doubly linked list node, linking NEXT/PREV slots and pointing to OBJECT.
See: DNODE-ALLOC DNODE-FREE DNODE-OBJECT."
  (prev nil :type (or null dnode))
  (next nil :type (or null dnode))
  object)

(defstruct
    (dlist
      (:constructor %make-dlist ())
      (:print-object
       (lambda (o stream)
	 (print-unreadable-object (o stream :type t :identity t)
	   (princ `(:nodes ,(dlist-nodes o)) stream)))))
  "A doubly linked list, linking FIRST/LAST to DNODE objects and storing
the nodes count.  Note that these lists are not automatically thread-safe,
explicit locks should be used by user code as necessary."
  (first nil :type (or null dnode))
  (last nil :type (or null dnode))
  (nodes 0 :type fixnum))


;;; Alloc/free cache for speed and locality

(defparameter *initial-cache-size* 1024)

(defun newlist (size)
  (let ((list (make-list size)))
    (loop
       for n on list
       do
	 (setf (car n) (%make-dnode)))
    list))

(defmacro make-lock ()
  #+ecl'(mp:make-lock)
  #-ecl'nil)

(defmacro with-lock ((lock) &body body)
  (let ((s-lock (gensym)))
    `(let ((,s-lock ,lock))
       #+ecl(mp:with-lock (,s-lock)
	      ,@body)
       #-ecl(progn
	      ,@body))))

(let* ((cache-lock (make-lock))
       (cache-size *initial-cache-size*)
       (cache-list '()))
  (declare (type fixnum cache-size))

  ;;; Init
  (with-lock (cache-lock)
    (setf cache-list (newlist cache-size)))

  ;;; XXX Use a per-thread cache?
  (defun dnode-alloc (object)
    "Allocate a DNODE object, making it point to OBJECT.  These objects are
allocated from a batch-filled cache for performance.  Note that this cache
uses an implicit lock for thread-safety.  See: DNODE-FREE."
    (with-lock (cache-lock)
      (when (null cache-list)
	(setf cache-list (newlist cache-size)
	      cache-size (* 2 cache-size)))
      (let ((dnode (pop cache-list)))
	(setf (dnode-object dnode) object)
	dnode)))

  (defun dnode-free (dnode)
    "Free a previously allocated DNODE object.  Note that by default,
DNODE-UNLINK, DLIST-RESET and DLIST-DESTROY will automatically free these.
If they're not freed, the GC should be able to reclaim the memory, but
freeing these objects allows to reuse them soon for better performance."
    (with-lock (cache-lock)
      (setf (dnode-prev dnode) nil
	    (dnode-next dnode) nil
	    (dnode-object dnode) nil)
      (push dnode cache-list)
      nil)))

(defmacro with-dnode ((var object) &body body)
  "Macro which allocates a DNODE object, binds it to VAR for the duration
of BODY and then frees it.  Care must be taken not to allow DLINK-UNLINK to
free VAR within BODY."
  (let ((s-dnode (gensym)))
    `(let* ((,s-dnode (dnode-alloc ,object))
	    (,var ,s-dnode))
       (unwind-protect
	    (progn
	      ,@body)
	 (dnode-free ,s-dnode)))))

(defmacro with-dlist ((var dlist) &body body)
  "Macro which ensures to free DLIST when done.  DLIST is also bound to VAR
within BODY."
  (let ((s-dlist (gensym)))
    `(let* ((,s-dlist ,dlist)
	    (,var ,s-dlist))
       (unwind-protect
	    (progn
	      ,@body)
	 (dlist-destroy ,s-dlist)))))

(defmacro do-dlist ((var dlist &key (reverse nil)) &body body)
  "Macro to iterate over every node of DLIST, with the current node bound to
VAR during BODY.  If REVERSE is T (defaults to NIL), the list is iterated
backwards.  Note that this macro takes the necessary precautions such that it
is possible to use DLIST-UNLINK on VAR during BODY."
  (let ((dnode-s (gensym))
	(next-dnode-s (gensym))
	(dlist-s (gensym)))
    `(loop
	with ,dlist-s = ,dlist
	for ,dnode-s = ,(if reverse
			    `(dlist-last ,dlist-s)
			    `(dlist-first ,dlist-s)) then ,next-dnode-s
	for ,next-dnode-s = (if ,dnode-s ,(if reverse
					      `(dnode-prev ,dnode-s)
					      `(dnode-next ,dnode-s))
				nil)
	while ,dnode-s
	do
	  (let ((,var ,dnode-s))
	    ,@body))))

(defun list<-dlist (dlist)
  "Returns a fresh standard LIST containing all objects of DLIST."
  (loop
     for dnode = (dlist-first dlist) then (dnode-next dnode)
     while dnode
     collect (dnode-object dnode)))

(defun dlist<-list (list)
  "Returns a fresh DLIST containing all objects of standard LIST."
  (let ((dlist (%make-dlist)))
    (loop
       for o in list
       do
	 (dlist-append dlist (dnode-alloc o)))
    dlist))

(defmacro map-dlist (function dlist &key (reverse nil) (results t))
  "Iterates through DLIST calling FUNCTION with every object (not DNODE).
If :RESULTS is T (the default), returns a freshly generated DLIST holding
the objects returned by FUNCTION; returns NIL otherwise.
If :REVERSE is T (which defaults to NIL), runs through DLIST backwards."
  (let ((dnode-s (gensym))
	(dlist-s (gensym))
	(function-s (gensym))
	(results-s (gensym)))
    `(let ((,function-s ,function)
	   (,results-s ,(if results `(%make-dlist) 'nil)))
       (loop
	  with ,dlist-s = ,dlist
	  for ,dnode-s = ,(if reverse
			      `(dlist-last ,dlist-s)
			      `(dlist-first ,dlist-s))
	  then ,(if reverse
		    `(dnode-prev ,dnode-s)
		    `(dnode-next ,dnode-s))
	  while ,dnode-s
	  do
	    ,(if results
		 `(dlist-append ,results-s
				(dnode-alloc
				 (funcall ,function-s
					  (dnode-object ,dnode-s))))
		 `(funcall ,function-s (dnode-object ,dnode-s))))
       ,results-s)))

(defun dlist-reset (dlist &optional (free t))
  "Resets DLIST, which must already have been created using MAKE-DLIST.
Emties DLIST, with every existing DNODE in DLIST freed if FREE is T
(the default)."
  (when free
    (do-dlist (dnode dlist)
      (dnode-free dnode)))
  (setf (dlist-first dlist) nil
	(dlist-last dlist) nil
	(dlist-nodes dlist) 0)
  nil)

(defmacro dlist-destroy (dlist)
  "Simple macro around DLIST-RESET."
  `(dlist-reset ,dlist))

(defun dlist-append (dlist dnode)
  "Appends DNODE to DLIST, returning the number of nodes in DLIST."
  (let ((lastnode (dlist-last dlist)))
    (if lastnode
	(setf (dnode-next lastnode) dnode
	      (dnode-prev dnode) lastnode
	      (dnode-next dnode) nil
	      (dlist-last dlist) dnode)
	(setf (dlist-first dlist) dnode
	      (dlist-last dlist) dnode
	      (dnode-prev dnode) nil
	      (dnode-next dnode) nil)))
  (the fixnum (incf (the fixnum (dlist-nodes dlist)))))

(defun dlist-insert (dlist dnode)
  "Inserts DNODE before every other item in DLIST, returning the number of
nodes in DLIST."
  (let ((firstnode (dlist-first dlist)))
    (if firstnode
	(setf (dnode-prev firstnode) dnode
	      (dnode-prev dnode) nil
	      (dnode-next dnode) firstnode
	      (dlist-first dlist) dnode)
	(setf (dlist-first dlist) dnode
	      (dlist-last dlist) dnode
	      (dnode-prev dnode) nil
	      (dnode-next dnode) nil)))
  (the fixnum (incf (the fixnum (dlist-nodes dlist)))))

(defun dlist-unlink (dlist dnode &key (free t))
  "Unlinks DNODE from DLIST, returning the number of nodes left in DLIST."
  (let ((prev (dnode-prev dnode))
	(next (dnode-next dnode)))
    (if prev
	(setf (dnode-next prev) next)
	(setf (dlist-first dlist) next))
    (if next
	(setf (dnode-prev next) prev)
	(setf (dlist-last dlist) prev)))
  (prog1
      (the fixnum (decf (the fixnum (dlist-nodes dlist))))
    (if free
	(dnode-free dnode))))

(defun dlist-insert-before (dlist before-dnode dnode)
  "Inserts DNODE into DLIST before BEFORE-DNODE which must also be in DLIST.
Returns the number of nodes in DLIST."
  (let ((prev (dnode-prev before-dnode))
	(next before-dnode))
    (setf (dnode-next dnode) next
	  (dnode-prev next) dnode)
    (if prev
	(setf (dnode-next prev) dnode
	      (dnode-prev dnode) prev)
	(setf (dlist-first dlist) dnode
	      (dnode-prev dnode) nil)))
  (the fixnum (incf (the fixnum (dlist-nodes dlist)))))

(defmacro dlist-swap (to-dlist from-dlist dnode &key (mode :append))
  "Macro around DLIST-UNLINK and DLIST-INSERT/DLIST-APPEND.  Swaps DNODE
from FROM-DLIST to TO-DLIST.  If MODE can be :APPEND (default) or :INSERT.
Returns the number of nodes in TO-DLIST.  Note that an explicit lock should
be used in concurrent code to prevent race conditions."
  (let ((to-dlist-s (gensym))
	(from-dlist-s (gensym))
	(dnode-s (gensym)))
    `(let ((,to-dlist-s ,to-dlist)
	   (,from-dlist-s ,from-dlist)
	   (,dnode-s ,dnode))
       (dlist-unlink ,from-dlist-s ,dnode-s :free nil)
       ,(if (eq mode :append)
	    `(dlist-append ,to-dlist-s ,dnode-s)
	    `(dlist-insert ,to-dlist-s ,dnode-s)))))

(defun make-dlist (&rest objects)
  "Creates a DLIST, filling it with optional OBJECTS, then returns it."
  (let ((dlist (%make-dlist)))
    (loop
       for o in objects
       do
	 (dlist-append dlist (dnode-alloc o)))
    dlist))
