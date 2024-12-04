#! /usr/bin/env bash

export AOC_DAY=4
source ../lib/utils.sh
set_LINE_ARRAY

function get_cross_word() {
  local x y

  x=$1
  y=$2

  for x_dir in -1 0 1; do
    (( x_dir == -1 && x < 3 )) && continue
    (( x_dir == 1 && x + 3 > ${#LINE_ARRAY[0]} - 1 )) && continue
    for y_dir in -1 0 1; do
      (( y_dir == 0 && x_dir == 0 )) && continue
      (( y_dir == -1 && y < 3 )) && continue
      (( y_dir == 1 && y + 3 > ${#LINE_ARRAY[@]} - 1 )) && continue
      
      local word=${LINE_ARRAY[$y]:$x:1}${LINE_ARRAY[$(( y + y_dir ))]:$(( x + x_dir )):1}${LINE_ARRAY[$(( y + y_dir * 2 ))]:$(( x + x_dir * 2 )):1}${LINE_ARRAY[$(( y + y_dir * 3 ))]:$(( x + x_dir * 3 )):1}

      [[ $word == "XMAS" ]] && (( ++RES ))
    done
  done
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
