#!/bin/bash

# Get the absolute path to the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the project base directory
BASE_DIR="$SCRIPT_DIR/.."

RESULT_DIR="$BASE_DIR/results"
mkdir -p "$RESULT_DIR"

# FIXME
MODEL="LLAMA3"
BIT="3BIT"

RESULT_FILE="$MODEL.$BIT.nsys-rep"

RUN_CMD="python $BASE_DIR/test_inference.py -m ../models/Llama-3.1-8B-Instruct-exl2/ -s"

eval "nsys profile \
  --output="$RESULT_DIR/$RESULT_FILE" \
  --force-overwrite=true \
  ${RUN_CMD}"

#nsys stats \
#  --force-overwrite=true \
#  --force-export=true \
#  --output=. \
#  --format=csv \
#  --timeunit=msec \
#  --report=nvtxkernsum \
#  "$RESULT_DIR/$RESULT_FILE"
