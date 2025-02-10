#!/bin/bash 
#SBATCH --job-name=rdrp_scan    # Job name
#SBATCH --partition=aoraki  # Partition (queue) name
#SBATCH --nodes=1               # Number of nodes
#SBATCH --ntasks-per-node=1     # Number of tasks (1 task per node)
#SBATCH --cpus-per-task=12      # Number of CPU cores per task
#SBATCH --mem=32G               # Job memory request
#SBATCH --time=10:00:00         # Time limit hrs:min:sec
#SBATCH --mail-user=stephanie.waller@otago.ac.nz
#SBATCH --output=rdrp_scan%j.log # Standard output and error log

# Set variables
base_name="$1"

# Use hmmer and the RdRpscan curated database to find divergent polymerase sequences
hmmscan --noali --tblout "${base_name}"_hmm_output.tbl RdRp_HMM_profile_CLUSTALO.db "${base_name}"_getorf_output.fasta > "${base_name}"_hmmscan_output.txt

# Filter the output to include only queries with domZ > 0
awk '
  BEGIN {print_query = 0}
  /Query:/ {query = $0}
  /Domain search space/ {
    if ($5 > 0) {
      print_query = 1
    } else {
      print_query = 0
    }
  }
  print_query {print}
' "${base_name}"_hmmscan_output.txt > "${base_name}"_filtered_output.txt