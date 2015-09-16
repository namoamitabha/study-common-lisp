#!/bin/bash

echo $1 $2 $3

args=("$@")

echo ${args[0]} ${args[1]} ${args[2]}

echo $@

echo Number of arguments passed: $#
# testing:
# ./passing-arguments-to-bash-script.sh 1 2 3

