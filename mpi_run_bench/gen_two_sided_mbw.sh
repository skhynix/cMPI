#!/bin/bash

SCRIPT_NAME="run_two_sided_mbw.sh"
export SCRIPT_NAME

rm ${SCRIPT_NAME}; touch ${SCRIPT_NAME}


BENCHMARKS="osu_pt2pt_mbw"
VERS="eth_2 ib_2 cxl_eth_2_cell64"
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