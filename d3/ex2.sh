#! /usr/bin/env bash

export AOC_DAY=3
source ../lib/utils.sh
set_LINE_ARRAY
#LINE_ARRAY=("mul(1,5)do()mul(1,6)don't()mul(1,7)")
set -e

RES=0
DO=1
for m in $(echo "${LINE_ARRAY[@]}" | grep -Eo '(mul\([0-9]+,[0-9]+\)|do\(\)|don'"'"'t\(\))'); do
  if [[ $m == "do()" ]]; then
    DO=1
    continue
  elif [[ $m == "don't()" ]]; then
    DO=0
    continue
  elif (( DO != 1 )); then
    continue
  fi
  R="${m#*,}"
  R="${R%\)}"
  L="${m%,*}"
  L="${L#mul\(}"
  (( RES += R * L ))
done


echo $RES
