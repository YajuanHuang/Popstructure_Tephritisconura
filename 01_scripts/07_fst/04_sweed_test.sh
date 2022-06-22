#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 2
#SBATCH -t 23:30:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -e ../../../07_fst/00_error_files/06_scotland_sweed.err
#SBATCH -o ../../../07_fst/00_error_files/06_scotland_sweed.out
#SBATCH -J sweedS
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/07_fst/05_SweeD/03_scotland

module load bioinfo-tools SweeD/4.0.0

cat ../00_contig_name_length.list | while read line; \
do name=$(echo "$line" | cut -f 1); \
length=$(($(echo "$line" | cut -f 2)/5000)); \
SweeD -name SCH.$name\
-input ../../../04_genotype_likelihood/01_scotland/05_split_vcfs/02_scotland70_1e6.$name.vcf \
-grid $length; done
