#! /usr/bin/env bash

if [[ $# != 1 || ! -f $1 ]] ; then
  exit 1
fi

declare -a LIST1 LIST2

readarray -t LINE_ARRAY < $1

for l in "${LINE_ARRAY[@]}"; do
  vals=( $l )
  (( ++LIST1[${vals[0]}] ))
  (( ++LIST2[${vals[1]}] ))
done

# declare -p LIST1 LIST2 >&2

RES=0

while (( ${#LIST1[@]} > 0 )); do
  INDX1=( ${!LIST1[@]} )
  INDX2=( ${!LIST2[@]} )

  (( --LIST1[${INDX1[0]}] ))
  (( --LIST2[${INDX2[0]}] ))

  if (( ${INDX1[0]} > ${INDX2[0]} )); then
    (( RES += (${INDX1[0]} - ${INDX2[0]}) ))
  else
    (( RES += (${INDX2[0]} - ${INDX1[0]}) ))
  fi

  if (( LIST1[${INDX1[0]}] == 0 )); then
    unset LIST1[${INDX1[0]}]
  fi

  if (( LIST2[${INDX2[0]}] == 0 )); then
    unset LIST2[${INDX2[0]}]
  fi

done

echo $RES
