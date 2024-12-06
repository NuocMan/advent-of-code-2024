#! /usr/bin/env bash

export AOC_DAY=5
source ../lib/utils.sh
set_LINE_ARRAY

function set_previous_to() {
  local IFS='|'
  local rule=( ${LINE_ARRAY[$1]} )
  PREVIOUS_TO[${rule[0]}]="${PREVIOUS_TO[${rule[0]}]} ${rule[1]}"
}

function is_corrected_order() {
  local IFS=','
  local update_pages=( ${LINE_ARRAY[$1]} )
  local -a passed_pages
  local -a rule_breaks

  for page in ${update_pages[@]}; do
    for previous in ${passed_pages[@]}; do
      if [[ ${PREVIOUS_TO[$page]} == *"$previous"* ]]; then
        (( ++rule_breaks[$page] ))
      fi
    done

    passed_pages+=( $page )
  done

  if [[ ${#rule_breaks[@]} == 0 ]]; then
    return 1
  fi

  for page_i in ${!update_pages[@]}; do
    page=${update_pages[$page_i]}

    go_back=${rule_breaks[$page]}
    [[ -z $go_back ]] && continue

    update_pages=(
      ${update_pages[@]:0:$(( page_i - go_back ))}
      ${page}
      ${update_pages[@]:$(( page_i - go_back )):$(( go_back ))}
      ${update_pages[@]:$(( page_i + 1 ))}
    )
  done
  echo ${update_pages[@]}
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
  new_update_page=( $(is_corrected_order $i) )
  if [[ $? == 0 ]]; then
    (( RES += ${new_update_page[$(( ${#new_update_page[@]} / 2 ))]} ))
  fi
  (( ++i ))
done

echo "Result : $RES"
