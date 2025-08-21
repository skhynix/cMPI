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

sudo su -c 'echo "disable=8" >|  /proc/mtrr'
sudo su -c 'echo "base=0x8000000000 size=0x8000000000 type=uncachable" >| /proc/mtrr'

sudo ../src/memsetLatencyTest /dev/dax1.0 0

sudo su -c 'echo "disable=8" >|  /proc/mtrr'
sudo su -c 'echo "base=0x8000000000 size=0x8000000000 type=write-back" >| /proc/mtrr'