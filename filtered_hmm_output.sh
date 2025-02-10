#!/bin/bash 
#SBATCH --job-name=filtered_hmm_output    # Job name
#SBATCH --partition=aoraki  # Partition (queue) name
#SBATCH --nodes=1               # Number of nodes
#SBATCH --ntasks-per-node=1     # Number of tasks (1 task per node)
#SBATCH --cpus-per-task=12      # Number of CPU cores per task
#SBATCH --mem=32G               # Job memory request
#SBATCH --time=10:00:00         # Time limit hrs:min:sec
#SBATCH --mail-user=stephanie.waller@otago.ac.nz
#SBATCH --output=filtered_hmm_output%j.log # Standard output and error log

# Define input and output file names
base_name="$1"
input_file="${base_name}_hmm_output.tbl"
output_file="${base_name}_first_hits_output.txt"

# Process the file
awk '!/^#/ {print $3 "\t" $1}' $input_file | sort -u -k1,1 | awk '!seen[$1]++' > $output_file