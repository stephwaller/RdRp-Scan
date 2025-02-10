# RdRp-Scan

Code used to 
1. Find and translate ORFs of contigs using getORF (**Filteredcontigs.sh**)
2. Takes the translated ORFs and uses hmmer and the curated RdRpScan database to find divergent polymerase seqeunces (**rdrp_scan.sh**)
3. Processes the final file so that only the first hits are seen (**filtered_hmm_output.sh**)
