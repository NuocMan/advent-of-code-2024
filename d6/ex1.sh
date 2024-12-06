#! /usr/bin/env bash

export AOC_DAY=6
source ../lib/utils.sh
set_LINE_ARRAY

WIDTH=${#LINE_ARRAY[0]}
HEIGHT=${#LINE_ARRAY[@]}


ROLLING_DIRECTION=URDL
# x y dir(U/R/D/L)
GUARD=()

# Search guard
for j in ${!LINE_ARRAY[@]}; do
  if [[ ${LINE_ARRAY[$j]} == *"^"* ]]; then

    guard_suffix=${LINE_ARRAY[$j]%%^*}
    GUARD=( ${#guard_suffix} $j 0)
    break
  fi
done

function is_next_pos_ok() {
  local x=$1
  local y=$2
  local dir=$3

  if [[ $dir == 0 ]]; then
    (( --y ))
  elif [[ $dir == 1 ]]; then
    (( ++x ))
  elif [[ $dir == 2 ]]; then
    (( ++y ))
  elif [[ $dir == 3 ]]; then
    (( --x ))
  fi

  if [[ ${LINE_ARRAY[$y]:$x:1} == '#' ]]; then
    return 1
  fi
  return 0
}

declare -A VISITED_POS

VISITED_POS["${GUARD[0]}-${GUARD[1]}"]="OK"
while (( ${GUARD[0]} >= 0 && ${GUARD[0]} < WIDTH \
           && ${GUARD[1]} >= 0 && ${GUARD[1]} < HEIGHT )); do

  while ! is_next_pos_ok ${GUARD[@]}; do
    GUARD[2]=$(( (${GUARD[2]} + 1) % 4 ))
  done

  if [[ ${GUARD[2]} == 0 ]]; then
    GUARD[1]=$(( ${GUARD[1]} - 1 ))
  elif [[ ${GUARD[2]} == 1 ]]; then
    GUARD[0]=$(( ${GUARD[0]} + 1 ))
  elif [[ ${GUARD[2]} == 2 ]]; then
    GUARD[1]=$(( ${GUARD[1]} + 1 ))
  elif [[ ${GUARD[2]} == 3 ]]; then
    GUARD[0]=$(( ${GUARD[0]} - 1 ))
  fi

  VISITED_POS["${GUARD[0]}-${GUARD[1]}"]="OK"
done

echo $(( ${#VISITED_POS[@]} - 1 ))
