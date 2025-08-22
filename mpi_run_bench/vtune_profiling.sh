FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile aps --collect-mode=mpi  -- ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_mbw -m :2097152 -i 2000 -s pscw

FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile vtune -collect hpc-performance –r vtune_mpi  -- ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_mbw -m :2097152 -i 2000 -s pscw
