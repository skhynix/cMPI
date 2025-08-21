#!/usr/bin/env python3
"""
Plot MPI bandwidth test results in horizontal subplots.
This script parses multiple output.log files and plots results with each version
in a separate subplot for easy comparison.
"""

import os
import re
import argparse
import sys
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path
import glob
import matplotlib.ticker as ticker


def vertion_titles():
    return {
        "cxl_eth_2": "CXL-SHM",
        "eth_2": "TCP over Ethernet",
        "ib_2": "TCP over Mellanox (CX-6 Dx)",
    }

def ver_title(ver):
    return vertion_titles()[ver]

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
            if 'Size' in line and ('Bandwidth' in line or 'MB/s' in line):
                data_start = True
                continue
                
            if data_start:
                # Skip lines containing "cxl shm"
                if 'cxl shm' in line:
                    continue
                    
                # Parse data lines
                parts = line.strip().split()
                if len(parts) >= 2:  # Ensure at least two columns of data
                    try:
                        size = float(parts[0])
                        if size > 8388608:
                            break
                        bandwidth = float(parts[1])
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

def plot_bandwidth_subplots(eval_name, versions, process_nums, output_file=None, title=None, results_base_dir=None):
    """Plot bandwidth performance in horizontal subplots, one per version"""
    
    # Create figure with subplots (one per version)
    fig, axes = plt.subplots(1, len(versions), figsize=(4.5*len(versions), 3.5))
    
    # If only one version, convert axes to array for consistent indexing
    if len(versions) == 1:
        axes = np.array([axes])
    
    # Colors and markers for different process counts
    colors = ['b', 'c', 'r', 'g', 'm', 'y', 'k', 'orange']
    markers = ['o', 's', '^', 'd', 'v', 'p', '*', 'x']
    
    # Keep track of all sizes for consistent x-axis
    all_sizes = set()
    
    # Create a mapping to store data for legend
    legend_handles = []
    legend_labels = []
    
    # Process data for each version
    for i, ver in enumerate(versions):
        ax = axes[i]
        has_data = False
        
        # Set title for the subplot
        ax.set_title(ver_title(ver), fontsize=14)
        
        # Process each process count for this version
        for j, proc in enumerate(process_nums):
            # Construct file path with optional base directory
            file_path = os.path.join(results_base_dir, eval_name, ver, proc, "output.log")
            
            if check_file_exists(file_path):
                sizes, bandwidths = parse_output_log(file_path)
                
                if sizes and bandwidths:
                    has_data = True
                    # Update all sizes for consistent x-axis
                    all_sizes.update(sizes)
                    
                    # Select color and marker based on process count
                    color_idx = j % len(colors)
                    marker_idx = j % len(markers)
                    
                    # Plot this dataset
                    line, = ax.plot(
                        sizes, 
                        bandwidths, 
                        marker=markers[marker_idx], 
                        color=colors[color_idx],
                        linestyle='-',
                        label=f"{proc} processes"
                    )
                    
                    # Store handle and label for first version only (for legend)
                    if i == 0:
                        legend_handles.append(line)
                        legend_labels.append(f"{proc} processes")
                else:
                    print(f"Warning: No valid data found in file {file_path}")


        # Configure each subplot
        ax.set_xscale('log', base=4)
        ax.set_xlabel('Message Size (Bytes)', fontsize=12)
        ax.grid(True, which="both", ls="--", alpha=0.7)
        
        # Only add y-label to the first subplot
        if i == 0:
            ax.set_ylabel('Bandwidth (MB/s)', fontsize=12)
        
        if ver == "cxl_eth_2" or ver == "ib_2":
            ax.set_ylim(0, 11000)
            ax.set_yticks(np.arange(0, 10001, 2000))
        
        ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, p: format(int(x), ',')))
    
    # Set consistent x-ticks across all subplots
    unique_sizes = sorted(list(all_sizes))
    x_sizes = [1, 4, 16, 64, 256, 1024, 4096, 16384, 65536, 262144, 1048576, 4194304]
    formatted_labels = format_size_labels(x_sizes)
    
    for ax in axes:
        ax.set_xticks(x_sizes)
        ax.set_xticklabels(formatted_labels, rotation=45)

    # Create a single legend for all subplots
    fig.legend(legend_handles, legend_labels, 
               loc='upper center', bbox_to_anchor=(0.5, 1.02),
               ncol=len(process_nums), frameon=True)
    
    # Adjust layout
    plt.tight_layout(rect=[0, 0.1, 1, 0.95])  # Make room for the legend and title
    
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
    parser = argparse.ArgumentParser(description='Plot MPI Bandwidth Performance in Horizontal Subplots')
    parser.add_argument('--eval', required=True, help='Evaluation name (e.g., osu_get_mbw)')
    parser.add_argument('--versions', required=True, help='List of versions, comma separated (e.g., cxl_eth_2,ib_2)')
    parser.add_argument('--processes', required=True, help='List of process numbers, comma separated (e.g., 2,4,8)')
    parser.add_argument('--output', help='Output chart file path (without extension)')
    parser.add_argument('--title', help='Chart title')
    parser.add_argument('--result_dir', help='Result Data Dir')

    args = parser.parse_args()
    
    # Split parameters into lists
    versions = args.versions.split(',')
    process_nums = args.processes.split(',')
    
    
    # Generate default output filename if not provided
    if not args.output:
        from datetime import datetime
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        args.output = f'{args.eval}_comparison_{timestamp}'
    
    # Plot chart
    success = plot_bandwidth_subplots(
        args.eval, 
        versions, 
        process_nums, 
        args.output, 
        args.title,
        args.result_dir
    )
    
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
