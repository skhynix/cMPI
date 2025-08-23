# cMPI: Using CXL Memory Sharing for MPI One-Sided and Two-Sided Inter-Node Communications

This repository contains artifacts of the paper `cMPI: Using CXL Memory Sharing for MPI One-Sided and
Two-Sided Inter-Node Communications`, the first work to optimize MPI point-to-point communication (both
one-sided and two-sided) using CXL memory sharing on a real CXL platform.

There are:
1. **mpich** -- An enhanced MPI implementation based on MPICH-4.2.3 that utilizes CXL Memory Sharing (CXL-SHM) to improve both one-sided and two-sided inter-node communications.
2. **cxl_shm_tests** --A comprehensive benchmark suite designed to test the latency and bandwidth of CXL Memory Sharing.
3. **mpi_run_bench** -- A script generation scaffold for the latency and bandwidth evaluation of MPI point-to-point inter-node communication over different interconnects.


For any questions, please 📧 swang166@ucmerced.edu. Thank you😊!

## [Related Publication](https://doi.org/10.1145/3712285.3759816)

```bibtex
@inproceedings{wang-cmpi,
  author = {Wang, Xi and Ma, Bin and Kim, Jongryool and Koh, Byungil and Kim, Hoshik and Li, Dong},
  title = {cMPI: Using CXL Memory Sharing for MPI One-Sided and Two-Sided Inter-Node Communications},
  booktitle = {Proceedings of the 37th ACM/IEEE International Conference for High Performance Computing, Networking, Storage and Analysis (SC'25)},
  year = {2025}
}
```


## Build environment

### Build environment for cMPI (MPI over CXL)

Create Conda Env

```
conda create -n mpich_cxl

conda activate mpich_cxl

conda install -c conda-forge compilers
```


Git Clone

```
cd $HOME

git clone --recursive https://github.com/skhynix/cMPI.git
```


Build MPICH

```
cd $HOME/cMPI/mpich

./autogen.sh

./configure --prefix=$CONDA_PREFIX --with-shared-memory=cxl MPICHLIB_CFLAGS="-march=native -mclflushopt"

make -j32 && make install
```

Build OMB benchmarks

```
conda activate mpich_cxl

cd $HOME

tar -xzvf osu-micro-benchmarks-7.4.tar.gz -C osu-micro-benchmarks-7.4-mpich_cxl

cd $HOME/osu-micro-benchmarks-7.4-mpich_cxl

./configure  --prefix=$CONDA_PREFIX/osu-micro-benchmarks CC=$CONDA_PREFIX/bin/mpicc CXX=$CONDA_PREFIX/bin/mpicxx

make -j32 && make install
```


### Build environment for MPICH

Create Conda Env

```
conda create -n mpich

conda activate mpich

conda install -c conda-forge compilers
```



Git Clone

```
git clone https://github.com/pmodels/mpich.git mpich-4.2.3

git checkout v4.2.3
```


Build MPICH

```
cd $HOME/mpich-4.2.3

./autogen.sh

./configure --prefix=$CONDA_PREFIX

make -j32 && make install
```

Build OMB benchmarks

```

cd $HOME

wget https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-7.4.tar.gz

conda activate mpich

tar -xzvf osu-micro-benchmarks-7.4.tar.gz -C osu-micro-benchmarks-7.4-mpich

cd $HOME/osu-micro-benchmarks-7.4-mpich

./configure  --prefix=$CONDA_PREFIX/osu-micro-benchmarks CC=$CONDA_PREFIX/bin/mpicc CXX=$CONDA_PREFIX/bin/mpicxx

make -j32 && make install
```



## Generate scripts for OMB evaluation

Generate scripts for OMB one-sided latency test
```
bash gen_one_sided_lat.sh
```

Generate scripts for OMB one-sided bandwidth test
```
bash gen_one_sided_mbw.sh
```

Generate scripts for OMB two-sided latency test
```
bash gen_two_sided_lat.sh
```

Generate scripts for OMB two-sided bandwidth test
```
bash gen_two_sided_mbw.sh
```

Generate scripts for pt2pt bandwidth test using MPICH_CXL with different cell size
```
bash gen_cxl_diff_cell.sh
```

## Run OMB evaluation
```
cd $HOME
```

Run OMB one-sided latency test
```
source ${HOME}/cMPI/mpi_run_bench/run_one_sided_lat.sh
```

Run OMB one-sided bandwidth test
```
source ${HOME}/cMPI/mpi_run_bench/run_one_sided_mbw.sh
```

Run OMB two-sided latency test
```
source ${HOME}/cMPI/mpi_run_bench/run_two_sided_lat.sh
```

Run OMB two-sided bandwidth test
```
source ${HOME}/cMPI/mpi_run_bench/run_two_sided_mbw.sh
```

Run pt2pt bandwidth test using MPICH_CXL with different cell size
```
source ${HOME}/cMPI/mpi_run_bench/run_cxl_diff_cell.sh
```

## Run memset latency evaluation for CXL memory sharing
Compile the benchmark
```
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/src/

make
```

Test latency with uncachable

```
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/

bash test_memset_lat_uncacheable.sh

```

Test latency with clflush

```
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/

bash test_memset_lat_clflush.sh
```

Test latency with clflushopt

```
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/

bash test_memset_lat_clflushopt.sh
```

## Run bandwidh test for CXL memory sharing
```
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/

bash test_seq_bw_devdax_read_nt.sh
```

## Evaluation of background section

Main Memory

```
# Latency
./mlc --latency_matrix

# Bandwidth
./mlc --bandwidth_matrix
```

CXL Memory Sharing (with caching; no cache flushing)

```
# Latency
./mlc --latency_matrix

# Bandwidth
./mlc --bandwidth_matrix

```

CXL Memory Sharing (with cache flushing)

```
# Latency
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/
bash test_memset_lat_clflushopt.sh

# Bandwidth
cd ${HOME}/cMPI/cxl_shm_tests/memo_ae/test_cxl/
bash test_seq_bw_devdax_read_nt.sh
```

TCP over Standard Ethernet NIC

```
# Latency
## on server
iperf3 -s -p 45678
## on client
iperf3 -p 45678 -c server_ip -t 30 -P 1 -u

# Bandwidth
## on server
iperf3 -s -p 45678
## on client
iperf3 -p 45678 -c server_ip -t 30 -P 1

```

TCP over Mellanox (CX-6 Dx)
```
# Latency
## on server
iperf3 -s -p 45678
## on client
iperf3 -p 45678 -c server_ip -t 30 -P 1 -u


# Bandwidth
## on server
iperf3 -s -p 45678
## on client
iperf3 -p 45678 -c server_ip -t 30 -P 8

```

RoCEv2 over Mellanox (CX-6 Dx)

```
# Latency
## on server
ib_write_lat --ib-dev=mlx5_1 -s 8 -n 10000
ib_write_lat --ib-dev=mlx5_1 -s 8 -n 10000  server_ip

# Bandwidth
## on server
ib_write_bw --ib-dev=mlx5_1 -s 65536 -n 10000
## on client
ib_write_bw --ib-dev=mlx5_1 -s 65536 -n 1000 server_ip

```
