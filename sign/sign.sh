#!/bin/bash

root=$(cd $(dirname $0); pwd -P)

[[ -r $1 ]] || exit 1
file=$1
ext=${file##*.}
file=$(cd $(dirname $file); pwd -P)/$(basename $file .$ext)
cd $root
[[ -r $file.$ext ]] || exit 1
java -jar signapk.jar certificate.pem key.pk8 $file.$ext $file\_signed.$ext
./verify.sh $file\_signed.$ext
