#!/bin/bash
PINNING=""
CONDA_ENV="mpich_cxl"
MPIRUN="${CONDA_DIR}/${CONDA_ENV}/bin/mpirun"
RUN_ENV1="FI_PROVIDER=tcp  FI_TCP_IFACE=ens1f1np1"
MPIARGS="-np ${NUM_PROCESS} -ppn ${PPN} -hostfile ${HOME}/mpi_sf/mpich_hostfile"
