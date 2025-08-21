#!/bin/bash

BIN="/home/sherry/osu-micro-benchmarks-7.4-${CONDA_ENV}/c/mpi/one-sided/osu_get_multi_lat -m :8388608 -i 2000 -s pscw"
BENCH_RUN="${BIN}"

# Mem size: 