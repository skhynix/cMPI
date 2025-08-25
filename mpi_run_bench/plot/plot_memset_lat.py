#!/usr/bin/env python3
import os
import re
import argparse
import sys
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path
import glob
import matplotlib.ticker as ticker


def parse_output_log(file_path):
    """Parse output.log file, extract Size and Bandwidth data"""
    sizes = []
    bandwidths = []

    try:
        with open(file_path, 'r') as f:
            content = f.readlines()

        # Find where data begins
        data_start = False
        for line in content:
            if 'Size' in line and 'Latency' in line:
                data_start = True
                continue

            if data_start:
                # Skip lines containing "cxl shm"
                if 'cxl shm' in line:
                    continue

                # Parse data lines
                parts = line.strip().split(',')
                if len(parts) >= 2:  # Ensure at least two columns of data
                    try:
                        size = float(parts[0])
                        bandwidth = float(parts[1])
                        if size < 64:
                            continue
                        sizes.append(size)
                        bandwidths.append(bandwidth)
                    except ValueError:
                        # Skip lines that can't be parsed
                        continue

        return sizes, bandwidths
    except Exception as e:
        print(f"Error parsing file {file_path}: {e}")
        return [], []

def check_file_exists(file_path):
    """Check if a file exists, notify user if not"""
    if not os.path.exists(file_path):
        print(f"Warning: File {file_path} does not exist")
        return False
    return True

def format_size_labels(sizes):
    """Format labels based on size: bytes, K, M or G"""
    formatted_labels = []
    for size in sizes:
        if size >= 1024*1024*1024:  # >= 1G
            formatted_labels.append(f"{size/(1024*1024*1024):.0f}G")
        elif size >= 1024*1024:     # >= 1M
            formatted_labels.append(f"{size/(1024*1024):.0f}M")
        elif size >= 1024:          # >= 1K
            formatted_labels.append(f"{size/1024:.0f}K")
        else:
            formatted_labels.append(f"{int(size)}")
    return formatted_labels

def plot_bandwidth(eval_name, versions, process_nums, output_file=None, title=None, results_base_dir=None):
    plt.figure(figsize=(4.5, 3))

    # Set color and marker style cycles
    colors = ['b', 'g', 'r', 'c', 'm', 'y', 'k']
    markers = ['o', 's', '^', 'd', 'v', 'p', '*']

    has_data = False
    all_sizes = []

    for i, ver in enumerate(versions):
        for j, proc in enumerate(process_nums):
            # Construct file path
            file_path = os.path.join(results_base_dir, eval_name, ver, proc, "output.log")

            if check_file_exists(file_path):
                sizes, bandwidths = parse_output_log(file_path)

                if sizes and bandwidths:
                    has_data = True
                    # Record all size values for x-axis ticks
                    all_sizes.extend(sizes)

                    # Select color and marker for each line
                    color_idx = i % len(colors)
                    marker_idx = i % len(markers)

                    plt.plot(
                        sizes,
                        bandwidths,
                        marker=markers[marker_idx],
                        color=colors[color_idx],
                        linestyle='-',
                        label=f"{ver}"
                    )
                else:
                    print(f"Warning: No valid data found in file {file_path}")

    if not has_data:
        print("Error: No valid data found, cannot generate chart")
        return False

    # Set x-axis to logarithmic scale (base 2)
    plt.xscale('log', base=2)
    plt.yscale('log', base=4)

    # plt.ylim(0, 260416)
    yticks = [1, 4, 16, 64, 256, 1024, 4096, 16384, 65536, 262144]
    plt.yticks(yticks, yticks)
    plt.gca().yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, p: format(int(x), ',')))


    # Set x-axis ticks to all unique size values and format labels
    if has_data and all_sizes:
        # Get all unique size values and sort them
        unique_sizes = sorted(list(set(all_sizes)))
        # Create formatted labels
        formatted_labels = format_size_labels(unique_sizes)
        plt.xticks(unique_sizes, formatted_labels, rotation=45)

    # Set chart properties
    plt.xlabel('Message Size (Bytes)')
    plt.ylabel('Memset Latency (us)')
    plt.grid(True, which="both", ls="--", lw=0.5)


    plt.legend()
    plt.tight_layout()

    # Save or display chart
    if output_file:
        try:
            plt.savefig(f"{output_file}.png", dpi=300, bbox_inches='tight')
            print(f"Chart saved to {output_file}.png")
            plt.savefig(f"{output_file}.pdf", dpi=300, bbox_inches='tight')
            print(f"Chart saved to {output_file}.pdf")
        except Exception as e:
            print(f"Error saving chart: {e}")
            return False
    else:
        plt.show()

    return True

def main():
    parser = argparse.ArgumentParser(description='Plot MPI Bandwidth Performance Charts')
    parser.add_argument('--eval', required=True, help='Evaluation name (e.g., osu_get_mbw)')
    parser.add_argument('--versions', required=True, help='List of versions, comma separated (e.g., clflush,clflushopt,uncacheable)')
    parser.add_argument('--processes', required=True, help='List of process numbers, comma separated (e.g., 2,4,8)')
    parser.add_argument('--output', help='Output chart file path (e.g., bandwidth_plot.png)')
    parser.add_argument('--title', help='Chart title')
    parser.add_argument('--result_dir', help='Result Data Dir')

    args = parser.parse_args()

    # Split parameters into lists
    versions = args.versions.split(',')
    process_nums = args.processes.split(',')

    # Plot chart
    success = plot_bandwidth(args.eval, versions, process_nums, args.output, args.title, args.result_dir)
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
