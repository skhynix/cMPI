#!/bin/bash

SCRIPT_NAME="run_cxl_diff_cell.sh"
export SCRIPT_NAME

rm ${SCRIPT_NAME}; touch ${SCRIPT_NAME}

BENCHMARKS="osu_pt2pt_mbw"
VERS="cxl_eth_2_cell32 cxl_eth_2_cell64 cxl_eth_2_cell128"
NUM_PROCESS="16 32"

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
