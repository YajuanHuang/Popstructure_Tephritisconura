#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 2
#SBATCH -t 12:30:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -J admix
#SBATCH -o ../00_error_files/14_scotland80_1e6_pruned_admix_K12345.out
#SBATCH -e ../00_error_files/14_scotland80_1e6_pruned_admix_K12345.err
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/04_genotype_likelihood/01_scotland

module load bioinfo-tools ADMIXTURE/1.3.0

admixture --cv=1000 16_scotland80_1e6_pruned_admix.bed 1 -j4

admixture --cv=1000 16_scotland80_1e6_pruned_admix.bed 2 -j4

admixture --cv=1000 16_scotland80_1e6_pruned_admix.bed 3 -j4

admixture --cv=1000 16_scotland80_1e6_pruned_admix.bed 4 -j4

admixture --cv=1000 16_scotland80_1e6_pruned_admix.bed 5 -j4
