#!/bin/bash
PINNING=""
CONDA_ENV="mpich_cxl"
MPIRUN="${CONDA_DIR}/${CONDA_ENV}/bin/mpirun"
RUN_ENV1="FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0"
MPIARGS="-np ${NUM_PROCESS} -ppn ${PPN} -hostfile ${HOME}/mpi_sf/mpich_hostfile -genv MPIR_CVAR_CH4_SHM_POSIX_IQUEUE_CELL_SIZE 131072"
