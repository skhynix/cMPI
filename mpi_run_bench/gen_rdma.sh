#!/bin/bash

SCRIPT_NAME="run_rdma.sh"
export SCRIPT_NAME

# export OMP_NUM_THREADS=32
rm ${SCRIPT_NAME}; touch ${SCRIPT_NAME}

BENCHMARKS="osu_get_mbw osu_get_multi_lat osu_pt2pt_mbw osu_pt2pt_multi_lat"
VERS="rdma_2"
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
