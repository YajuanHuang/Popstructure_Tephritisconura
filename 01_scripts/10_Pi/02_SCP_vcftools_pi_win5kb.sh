#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -e 00_error_files/02_SCP_vcftools_pi_win5kb.err
#SBATCH -o 00_error_files/02_SCP_vcftools_pi_win5kb.out
#SBATCH -J vpiP
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/10_Pi

module load bioinfo-tools vcftools/0.1.16

vcftools --vcf ../04_genotype_likelihood/03_SCP/01_SCP.vcf  \
--window-pi 5000 --out 02_SCP80_1e6_vcftools_win5kb
