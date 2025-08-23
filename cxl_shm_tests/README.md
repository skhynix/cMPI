# cxl\_shm\_tests

This repository contains benchmarks to test the latency and bandwidth of CXL Memory Sharing.

They are the correpsonding artifacts of the paper `cMPI: Using CXL Memory Sharing for MPI One-Sided and
Two-Sided Inter-Node Communications`, the first work to optimize MPI point-to-point communication (both
one-sided and two-sided) using CXL memory sharing on a real CXL platform.

See details in [https://github.com/skhynix/cMPI/tree/main/cxl_shm_tests/memo_ae](https://github.com/skhynix/cMPI/tree/main/cxl_shm_tests/memo_ae).


## [Related Publication](https://doi.org/10.1145/3712285.3759816)

```bibtex
@inproceedings{wang-cmpi,
  author = {Wang, Xi and Ma, Bin and Kim, Jongryool and Koh, Byungil and Kim, Hoshik and Li, Dong},
  title = {cMPI: Using CXL Memory Sharing for MPI One-Sided and Two-Sided Inter-Node Communications},
  booktitle = {Proceedings of the 37th ACM/IEEE International Conference for High Performance Computing, Networking, Storage and Analysis (SC'25)},
  year = {2025}
}
```

## Acknowledgement
Some parts of this source code and the methodology are inspired by the marvalous work in this [publication(MICRO23-Sun)](https://arxiv.org/abs/2303.15375), this [publication(FAST20-Yang)](https://www.usenix.org/conference/fast20/presentation/yang), and this [reposiroty(OptaneStudy)](https://github.com/NVSL/OptaneStudy/tree/master).
