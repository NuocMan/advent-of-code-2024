#! /usr/bin/env bash

function get_input_file() {
  local INPUT
  [[ -z ${AOC_DAY} ]] && {
    echo "Please set AOC_DAY environment variable" >&2
    exit 1
  }
  if [[ -f "$PWD"/input ]]; then
    INPUT=$(cat "$PWD"/input)
  else
    INPUT=$(curl --silent \
                 --cookie "session=${AOC_SESSION}" \
                 "https://adventofcode.com/2024/day/${AOC_DAY}/input")
  fi
  if [[ $? != 0 ]]; then
    echo "Could not retrieve input file" >&2
    exit 1
  fi

  if [[ ! -f "$PWD"/input && ! "$1" == "--no-save" ]]; then
    echo "$INPUT" > "$PWD"/input
  fi

  echo "$INPUT"
}

function set_LINE_ARRAY() {
  local INPUT

  if [[ -p /dev/stdin ]]; then
    INPUT=$(</dev/stdin)
  else
    INPUT=$(get_input_file)
  fi
  [[ $? != 0 ]] && exit 1
  readarray -t LINE_ARRAY <<<$INPUT
}
