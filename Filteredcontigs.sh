#!/bin/bash
#SBATCH --job-name=filetered_contigs    # Job name
#SBATCH --partition=aoraki         # Partition (queue) name
#SBATCH --ntasks=1                # Run a single task
#SBATCH --cpus-per-task=12         # Number of CPU cores per task
#SBATCH --mem=24G                  # Job memory request
#SBATCH --time=10:00:00           # Time limit hrs:min:sec
#SBATCH --mail-user=stephanie.waller@otago.ac.nz
#SBATCH --output=filtered_contigs%j.log   # Standard output and error log

#Set variables
base_name="$1"

# Extract contig IDs
awk '{print $1}' "${base_name}"_summary.table_virus_5.txt > "${base_name}"_contig_ids.txt

seqtk subseq "${base_name}".contigs.fa "${base_name}"_contig_ids.txt > "${base_name}"_filtered_contigs.fasta

echo "Filtered contigs have been saved to filtered_contigs.fa"

# Find and translate translatable open reading frames
getorf -maxsize 50000 -minsize 200 -find 0 -outseq "${base_name}"_getorf_output.fasta -sequence "${base_name}"_filtered_contigs.fasta
