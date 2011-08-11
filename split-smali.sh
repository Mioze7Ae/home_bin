#!/bin/bash

file=$(cd $(dirname "$1"); pwd -P)/$(basename "$1" .smali)
[[ -f "$file.smali" ]] || exit 1
dir=$(basename "${file}")
[[ -d "$dir" ]] && exit 1

mkdir -p $(basename "${file}")
cd $(basename "${file}")
pwd
csplit "${file}.smali" '/^.method /' '{*}'
for x in xx* ; do
    y=$(grep ^.method $x | tr ' ' '\n' | grep \( | cut -f 1 -d \( | tr -d '<>$')
    [[ -z "$y" ]] && continue
    mv $x $x-$y
done
