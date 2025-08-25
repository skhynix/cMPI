## Directory Structure Requirements

The script assumes the result files follow this directory structure:
```
results/
  └── <eval_name>/
      └── <version>/
          └── <process_num>/
              └── output.log
```

For example:
```
results/
  └── osu_get_mbw/
      ├── cxl_eth_2/
      │   ├── 2/
      │   │   └── output.log
      │   └── 4/
      │       └── output.log
      └── ib_2/
          ├── 2/
          │   └── output.log
          └── 4/
              └── output.log
```

## Installing Dependencies

Before using this script, make sure the required dependencies are installed:

```bash
# Using pip
pip3 install matplotlib numpy
```

## Usage

```bash
python3 plot_bw.py --eval <evaluation_name> --versions <version_list> --processes <process_num_list> [--output <output_file>] [--title <chart_title>]
```

### Parameters

- `--eval`: Evaluation name, corresponding to the first level subdirectory of the results directory (e.g., osu_get_mbw)
- `--versions`: List of versions, comma separated (e.g., cxl_eth_2,ib_2)
- `--processes`: List of process numbers, comma separated (e.g., 2,4,8)
- `--output`:  Output chart file path (e.g., bandwidth_plot.png)
- `--title`: Chart title
- `--result_dir`: Result data source directory

### Examples

```
cd mpi_run_bench/plot/

# cache coherency latency
python3 plot_memset_lat.py --eval memset_latency --versions uncacheable,clflush,clflushopt --processes 1 --output memset_latency --title "Memset Latency Comparison" --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"

# MPI bandwidth
python3 plot_pt2pt_bw_subplot.py --eval osu_pt2pt_mbw --versions eth_2,cxl_eth_2_cell64,ib_2 --processes 2,4,8,16,32 --output osu_pt2pt_mbw --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"
python3 plot_get_bw_subplot.py --eval osu_get_mbw --versions eth_2,cxl_eth_2,ib_2 --processes 2,4,8,16,32 --output osu_get_mbw --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"

# MPI latency
python3 plot_lat_subplot.py --eval osu_pt2pt_multi_lat --versions eth_2,cxl_eth_2_cell64,ib_2 --processes 2,4,8,16,32 --output osu_pt2pt_multi_lat --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"
python3 plot_get_lat_subplot.py --eval osu_get_multi_lat --versions eth_2,cxl_eth_2,ib_2 --processes 2,4,8,16,32 --output osu_get_multi_lat --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"

# message cell threshold
python3 plot_bw.py  --eval osu_pt2pt_mbw --versions cxl_eth_2_cell128,cxl_eth_2_cell64,cxl_eth_2_cell32,cxl_eth_2 --processes 16,32 --output osu_pt2pt_mbw_cell --result_dir "/home/sherry/MPI_over_CXL/mpi_run_bench/results"
```

### Draw Figures

```
cd mpi_run_bench/plot

bash plot.sh
```

See figures in `mpi_run_bench/plot/`
