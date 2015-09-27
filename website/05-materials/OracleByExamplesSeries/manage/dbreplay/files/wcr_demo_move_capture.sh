#!/bin/csh
#
# $1 source directory and $2 destination directory
#

mkdir -p $2; cp $1/*.rec $1/*.wmd $1/*.start $2 > /dev/null
