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
