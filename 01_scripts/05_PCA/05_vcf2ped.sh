#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 2:00:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o ../../05_PCA/00_error_files/06_vcf2ped.out
#SBATCH -e ../../05_PCA/00_error_files/06_vcf2ped.err
#SBATCH -J vcf2ped
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/04_genotype_likelihood/01_scotland

module load bioinfo-tools vcftools/0.1.16

vcftools --vcf 01_scotland80.vcf \
--plink --out 06_scotland80_1e6_vcf2ped
