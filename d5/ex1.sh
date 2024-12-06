#! /usr/bin/env bash

export AOC_DAY=5
source ../lib/utils.sh
set_LINE_ARRAY

function set_previous_to() {
  local IFS='|'
  local rule=( ${LINE_ARRAY[$1]} )
  PREVIOUS_TO[${rule[0]}]="${PREVIOUS_TO[${rule[0]}]} ${rule[1]}"
}

function is_correct_order() {
  local IFS=','
  local update_pages=( ${LINE_ARRAY[$1]} )
  local -a passed_pages

  for page in "${update_pages[@]}"; do

    for previous in ${passed_pages[@]}; do
      [[ ${PREVIOUS_TO[$page]} == *"$previous"* ]] && return 1
    done

    passed_pages+=( $page )
  done

  return 0
}

i=0
declare -a PREVIOUS_TO
while [[ -n ${LINE_ARRAY[$i]} ]]; do
  set_previous_to $i
  (( ++i ))
done

(( ++i ))


RES=0
while [[ -n ${LINE_ARRAY[$i]} ]]; do
  if is_correct_order $i; then
    IFS=','
    update_page=( ${LINE_ARRAY[$i]} )
    (( RES += ${update_page[$(( ${#update_page[@]} / 2 ))]} ))
  fi
  (( ++i ))
done

echo "Result : $RES"
