#! /usr/bin/env bash

if [[ $# != 1 || ! -f $1 ]] ; then
  exit 1
fi

declare -a LIST1 LIST2

readarray -t LINE_ARRAY < $1

RES=0
for l in "${LINE_ARRAY[@]}"; do
  REPORT=( $l )

  unset LEVEL DIRECTION
  for i in "${!REPORT[@]}"; do

    unset STATUS
    if [[ $i != 0 ]]; then
      DIFF=$(( ${REPORT[$i]} - ${REPORT[$((i - 1))]} ))
      if (( $DIFF == 0 )); then
        break
      fi
      if (( $DIFF > 0 )); then
        DIR=INC
      else
        DIR=DEC
      fi
    else
      continue
    fi

    if [[ -z $DIRECTION ]]; then
      DIRECTION=$DIR
    fi
    
    if [[ $DIRECTION != $DIR ]] || (( $DIFF > 3 || $DIFF < -3 || $DIFF == 0 )); then
      break
    fi
    STATUS=OK
  done

  
  if [[ $STATUS == "OK" ]]; then
    (( ++RES ))
    echo "${REPORT[@]} : SAFE" >&2
  else
    echo "${REPORT[@]} : UNSAFE" >&2
  fi
done

echo $RES
