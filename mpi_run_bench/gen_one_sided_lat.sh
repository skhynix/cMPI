#!/bin/bash

SCRIPT_NAME="run_one_sided_lat.sh"
export SCRIPT_NAME

rm ${SCRIPT_NAME}; touch ${SCRIPT_NAME}

BENCHMARKS="osu_get_multi_lat"
VERS="eth_2 ib_2 cxl_eth_2"
NUM_PROCESS="2 4 8 16 32"

for BENCH in ${BENCHMARKS};
do

    for VER in ${VERS};
    do
        for N in ${NUM_PROCESS};
        do
            CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
            echo "current_time ${CURRENT_TIME}"
            ./scripts/run_bench.sh -B ${BENCH} -N ${N} -V ${VER}
        done
    done
done
