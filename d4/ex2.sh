#! /usr/bin/env bash

export AOC_DAY=4
source ../lib/utils.sh
set_LINE_ARRAY

function get_cross_word() {
  local x y

  x=$1
  y=$2

  (( x < 1 )) && return 1
  (( x + 1 > ${#LINE_ARRAY[0]} - 1 )) && return 1
  (( y < 1 )) && return 1
  (( y + 1 > ${#LINE_ARRAY[@]} - 1 )) && return 1
      
  local cross=(
    ${LINE_ARRAY[$(( y - 1 ))]:$(( x - 1 )):1}${LINE_ARRAY[$(( y ))]:$(( x )):1}${LINE_ARRAY[$(( y + 1 ))]:$(( x + 1 )):1}
    ${LINE_ARRAY[$(( y - 1 ))]:$(( x + 1 )):1}${LINE_ARRAY[$(( y ))]:$(( x )):1}${LINE_ARRAY[$(( y + 1 ))]:$(( x - 1 )):1}
  )

  [[ ${cross[0]} == "MAS" && ${cross[1]} == "MAS" ]] \
    || [[ ${cross[0]} == "MAS" && ${cross[1]} == "SAM" ]] \
    || [[ ${cross[0]} == "SAM" && ${cross[1]} == "SAM" ]] \
    || [[ ${cross[0]} == "SAM" && ${cross[1]} == "MAS" ]] \
    && (( ++RES ))
}

RES=0
LEN=${#LINE_ARRAY[0]}
X_INDEXES=( $(seq 0 $(( LEN - 1 ))) )
for j in ${!LINE_ARRAY[@]}; do
  for i in ${X_INDEXES[@]}; do
    get_cross_word $i $j
  done
done

echo $RES
