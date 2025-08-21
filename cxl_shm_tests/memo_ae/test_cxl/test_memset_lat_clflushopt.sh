#!/bin/bash
NUM_THREADS=32
STEP=2
ITERATION=3
OP_MAX=3

bash ../../util_scripts/config_all.sh
source ../../util_scripts/env.sh

FOLDER_NAME=memset_lat_clflush_test
CURR_RESULT_PATH=../results/$FOLDER_NAME
mkdir -p $CURR_RESULT_PATH

sudo ../src/memsetLatencyTest /dev/dax1.0 2
