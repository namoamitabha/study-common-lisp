#!/bin/bash

encoding_in="GB2312"
encoding_out="UTF-8"
echo "convert $1 txt files... from $encoding_in to $encoding_out"

for f in $1
do
    #`chardet $f`
    #echo $chardet
    echo `iconv -f $encoding_in -t $encoding_out "$f" > "$f.utf8.txt"`

done

# Usage example:
# ./conver-txt-encoding.sh "/home/angelo/git-root/atos-AlarmSheetRetrieve/test-data/txt-convert-encoding/origin-txt/*"
