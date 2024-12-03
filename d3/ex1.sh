#! /usr/bin/env bash

export AOC_DAY=3
source ../lib/utils.sh
set_LINE_ARRAY

RES=0
for m in $(echo "${LINE_ARRAY[@]}" | grep -Eo 'mul\([0-9]+,[0-9]+\)'); do
  R="${m#*,}"
  R="${R%\)}"
  L="${m%,*}"
  L="${L#mul\(}"
  (( RES += R * L ))
done

echo $RES
