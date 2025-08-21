/**
* dax_memset_benchmark.c - A benchmark to measure memset latency to a DAX device
*
 * This program measures the latency of memset operations to a specified
* /dev/dax device, using direct memory mapping for best performance.
*/
 
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
 
// Define constants
#define MIN_SIZE 1
#define MAX_SIZE (128 * 1024)  // 128KB
#define MMAP_SIZE  (32 * 1024 * 1024)  // 32MB
#define ITERATIONS 1000
#define WARMUP_ITERATIONS 10
#define STEP_FACTOR 2        // Power of 2 progression
 
// Function to get current time in nanoseconds
static inline uint64_t get_time_ns(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
}
 
static void flush_cache_opt(void *ptr, size_t size) {
    char *p = (char *)ptr;
    for (size_t i = 0; i < size; i += 64) {  // Typically cache line size is 64 bytes
        asm volatile("clflushopt (%0)\n\t"
                     :
                     : "r"(p + i)
                     : "memory");
    }
    asm volatile("sfence\n\t" ::: "memory");
}

static void flush_cache(void *ptr, size_t size) {
    char *p = (char *)ptr;
    for (size_t i = 0; i < size; i += 64) {  // Typically cache line size is 64 bytes
        asm volatile("clflush (%0)\n\t"
                     :
                     : "r"(p + i)
                     : "memory");
    }
    asm volatile("sfence\n\t" ::: "memory");
}
 
// Function to perform memset benchmark for a given size using mmap
double benchmark_memset_dax(void *dax_mapping, size_t size, int opt) {
    uint64_t start, end, elapsed = 0;
   
    // First do some warm-up iterations (results not counted)
    for (int i = 0; i < WARMUP_ITERATIONS; i++) {
        memset(dax_mapping, 0xAA, size);
        flush_cache_opt(dax_mapping, size);
    }
   
    // Now do the measured iterations
    for (int i = 0; i < ITERATIONS; i++) {
        // Ensure CPU serialization before measurement
        asm volatile("" ::: "memory");
       
        start = get_time_ns();
        memset(dax_mapping, i & 0xFF, size);
        if (opt == 0) {
            // Uncacheable
            // do nothing
        } else if (opt == 1) {
            // clflush
            flush_cache(dax_mapping, size);
        } else if (opt == 2) {
            // clflushopt
            flush_cache_opt(dax_mapping, size);
        }
        end = get_time_ns();
       
        elapsed += (end - start);
       
        // Flush cache between iterations
        flush_cache_opt(dax_mapping, size);
       
        // Small delay between iterations
        usleep(10);
    }
   
    // Return average latency in microseconds
    return (double)elapsed / ITERATIONS / 1000.0;
}
 
int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <dax_device_path> <uncacheable:0;clflush:1;clflushopt:2>\n", argv[0]);
        return 1;
    }
   
    const char *device_path = argv[1];
    int opt = atoi(argv[2]);
    int fd;
    void *dax_mapping;
    size_t map_size = MMAP_SIZE;
   
    // Open the DAX device
    fd = open(device_path, O_RDWR);
    if (fd < 0) {
        perror("Failed to open DAX device");
        return 1;
    }
   
    // Ensure the mapping size is large enough
    if (map_size < MAX_SIZE) {
        fprintf(stderr, "DAX device is too small. Need at least %d bytes.\n", MAX_SIZE);
        close(fd);
        return 1;
    }
   
    // Map the DAX device into memory
    dax_mapping = mmap(NULL, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (dax_mapping == MAP_FAILED) {
        perror("Failed to mmap DAX device");
        close(fd);
        return 1;
    }
   
    printf("Benchmark: memset latency to DAX device %s\n", device_path);
    printf("Parameters: %d iterations per size, measuring sizes from %d to %d bytes\n",
           ITERATIONS, MIN_SIZE, MAX_SIZE);
    printf("\n");
    printf("Size (bytes),Latency (μs)\n");
   
    // Run benchmark for each size
    for (size_t size = MIN_SIZE; size <= MAX_SIZE; size *= STEP_FACTOR) {
        double latency = benchmark_memset_dax(dax_mapping, size, opt);
        printf("%zu,%.3f\n", size, latency);
        fflush(stdout);  // Ensure output is not buffered
    }
   
    // Clean up
    munmap(dax_mapping, map_size);
    close(fd);
   
    return 0;
}