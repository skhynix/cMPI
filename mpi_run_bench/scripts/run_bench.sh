#!/bin/bash

# Todo: change DIR
export DIR=${HOME}/cMPI/mpi_run_bench
export CONDA_DIR=${HOME}/miniconda3/envs

function func_cache_flush() {
    echo 3 | sudo tee /proc/sys/vm/drop_caches
    free
    return
}

function func_prepare() {
    echo "Preparing benchmark start..."

	ulimit -m unlimited
	ulimit -v unlimited
	ulimit -d unlimited
	ulimit -s unlimited

	# sudo sysctl kernel.perf_event_max_sample_rate=100000
	echo 0 | sudo tee /proc/sys/kernel/numa_balancing
	echo 0 | sudo tee  /proc/sys/kernel/kptr_restrict
	echo 0 | sudo tee  /proc/sys/kernel/perf_event_paranoid

	DATE=$(date +%Y%m%d%H%M)
	# echo 1 > /sys/kernel/debug/tracing/events/migrate/mm_migrate_pages/enable


    if [[ -e ${DIR}/config_settings/${VER}.sh ]]; then
	    source ${DIR}/config_settings/${VER}.sh
	else
	    echo "ERROR: ${VER}.sh does not exist."
	    exit -1
	fi
	

	if [[ -e ${DIR}/bench_cmds/${BENCH_NAME}.sh ]]; then
	    source ${DIR}/bench_cmds/${BENCH_NAME}.sh
	else
	    echo "ERROR: ${BENCH_NAME}.sh does not exist."
	    exit -1
	fi
}

function func_usage() {
    echo
    echo -e "Usage: $0 [-B benchmark] [-V version] [-M mempolicy] [-LM localmem]..."
    echo
    echo "  -B,   --benchmark   [arg]    benchmark name to run. e.g., Graph500, XSBench, etc"
    echo "  -V,   --version     [arg]    version to run. e.g., autonuma, TPP, etc"
	echo "  -M,   --mempolicy   [arg]    memory policy to run. e.g., cpu1.membind0_1_2, cpu1.membind1_2, etc"
	echo "  -LM,  --localmem    [arg]    local memory size. e.g., 65G, 105G, etc"
    echo "        --cxl                  enable cxl mode [default: disabled]"
    echo "  -?,   --help"
    echo "        --usage"
    echo
}

# get options:
while (( "$#" )); do
    case "$1" in
	-B|--benchmark)
	    if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
		BENCH_NAME=( "$2" )
		shift 2
	    else
		echo "Error: Argument for $1 is missing" >&2
		func_usage
		exit -1
	    fi
	    ;;
	-V|--version)
	    if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
		VER=( "$2" )
		shift 2
	    else
		echo "Error: Argument for $1 is missing" >&2
		func_usage
		exit -1
	    fi
	    ;;
	-N|--numprocess)
	    if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
		NUM_PROCESS=( "$2" )
		export NUM_PROCESS
		PPN=$((NUM_PROCESS / 2))
		export PPN
		shift 2
	    else
		echo "Error: Argument for $1 is missing" >&2
		func_usage
		exit -1
	    fi
	    ;;
	-P|--perf)
	    CONFIG_PERF=on
	    shift 1
	    ;;
	-H|-?|-h|--help|--usage)
	    func_usage
	    exit
	    ;;
	*)
	    echo "Error: Invalid option $1"
	    func_usage
	    exit -1
	    ;;
    esac
done

function func_main() {
    TIME="/usr/bin/time"

    # make directory for results
    mkdir -p ${DIR}/results/${BENCH_NAME}/${VER}/${NUM_PROCESS}
    LOG_DIR=${DIR}/results/${BENCH_NAME}/${VER}/${NUM_PROCESS}

	CMD="${RUN_ENV1} ${MPIRUN} ${MPIARGS} ${BENCH_RUN} 2>&1 | tee -a ${LOG_DIR}/output.log"
    # func_cache_flush
	echo "sleep 10" | tee -a ${DIR}/${SCRIPT_NAME}
	echo "echo '${CMD}' | tee ${LOG_DIR}/output.log" | tee -a ${DIR}/${SCRIPT_NAME}
	echo "${CMD}" | tee -a ${DIR}/${SCRIPT_NAME}
	echo "" | tee -a ${DIR}/${SCRIPT_NAME}
}

func_prepare
func_main
