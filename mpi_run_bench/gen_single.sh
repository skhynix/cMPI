#!/bin/bash

SCRIPT_NAME="run_single.sh"
export SCRIPT_NAME

rm ${SCRIPT_NAME}; touch ${SCRIPT_NAME}

BENCHMARKS="osu_get_latency osu_get_bw osu_put_latency osu_put_bw"
VERS="eth_2 ib_2 cxl_eth_2"
NUM_PROCESS="2"

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


BENCHMARKS="osu_pt2pt_latency"
VERS="eth_2 ib_2 cxl_eth_2_cell64"
NUM_PROCESS="2"

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