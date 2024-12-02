#! /usr/bin/env bash

export AOC_DAY=1
source ../lib/utils.sh
set_LINE_ARRAY

declare -a LIST1 LIST2

for l in "${LINE_ARRAY[@]}"; do
  vals=( $l )
  (( ++LIST1[${vals[0]}] ))
  (( ++LIST2[${vals[1]}] ))
done

# declare -p LIST1 LIST2 >&2

RES=0

for i in "${!LIST1[@]}"; do

  VALUE1=$i
  NBVALUE1=${LIST1[i]}
  NBVALUE2=${LIST2[$VALUE1]:=0}

  (( RES += $NBVALUE1 * $VALUE1 * $NBVALUE2 ))

done

echo $RES
