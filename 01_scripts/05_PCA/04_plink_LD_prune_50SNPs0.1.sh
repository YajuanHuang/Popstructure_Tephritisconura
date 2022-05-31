#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 5
#SBATCH -t 02:00:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o ../00_error_files/06_LD_plink/05_LD_prune.out
#SBATCH -e ../00_error_files/06_LD_plink/05_LD_prune.err
#SBATCH -J LD_prune
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/05_PCA/05_LD_plink

module load bioinfo-tools plink/1.90b4.9

plink --allow-extra-chr --file 01_scotland80_1e6_vcf2ped \
--indep-pairwise 50 1 0.1 --out 05_scotland80_1e6_pruned
