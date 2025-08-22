sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/eth_2/2/output.log

sleep 10
echo ' ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/ib_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/ib_2/2/output.log
 ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/ib_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/cxl_eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/cxl_eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_get_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_get_latency/cxl_eth_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/eth_2/2/output.log

sleep 10
echo ' ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/ib_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/ib_2/2/output.log
 ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/ib_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/cxl_eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/cxl_eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_put_latency -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_latency/cxl_eth_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/eth_2/2/output.log

sleep 10
echo ' ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/ib_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/ib_2/2/output.log
 ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/ib_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/cxl_eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/cxl_eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/one-sided/osu_put_bw -m :8388608 -i 2000 -s pscw 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_put_bw/cxl_eth_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/eth_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/eth_2/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/eth_2/2/output.log

sleep 10
echo ' ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/ib_2/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/ib_2/2/output.log
 ${HOME}/miniconda3/envs/mpich/bin/mpirun -genv FI_PROVIDER tcp  -genv FI_TCP_IFACE ens1f1np1 -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile ${HOME}/osu-micro-benchmarks-7.4-mpich/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/ib_2/2/output.log

sleep 10
echo 'FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile -genv MPIR_CVAR_CH4_SHM_POSIX_IQUEUE_CELL_SIZE 65536 ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/cxl_eth_2_cell64/2/output.log' | tee ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/cxl_eth_2_cell64/2/output.log
FI_PROVIDER=tcp  FI_TCP_IFACE=ens3f0 ${HOME}/miniconda3/envs/mpich_cxl/bin/mpirun -np 2 -ppn 1 -hostfile ${HOME}/mpi_sf/mpich_hostfile -genv MPIR_CVAR_CH4_SHM_POSIX_IQUEUE_CELL_SIZE 65536 ${HOME}/osu-micro-benchmarks-7.4-mpich_cxl/c/mpi/pt2pt/standard/osu_latency -m :8388608 -i 2000 2>&1 | tee -a ${HOME}/cMPI/mpi_run_bench/results/osu_pt2pt_latency/cxl_eth_2_cell64/2/output.log

