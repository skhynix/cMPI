#!/bin/bash
PINNING=""
CONDA_ENV="mpich"
MPIRUN="${CONDA_DIR}/${CONDA_ENV}/bin/mpirun"
RUN_ENV1=""
MPIARGS="-genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np ${NUM_PROCESS} -ppn ${PPN} -hostfile /home/sherry/mpi_sf/mpich_hostfile"
