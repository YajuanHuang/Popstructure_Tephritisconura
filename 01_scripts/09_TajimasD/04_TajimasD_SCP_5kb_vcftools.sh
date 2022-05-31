#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH --mail-user=yajuan_huang@outlook.com
#SBATCH --mail-type=FAIL
#SBATCH -e 09_TajimasD/00_error_files/04_TajimasD_SCP_5kb_vcftools.err
#SBATCH -o 09_TajimasD/00_error_files/04_TajimasD_SCP_5kb_vcftools.out
#SBATCH -J SCP_D_vcftools
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/09_TajimasD/05_Tajima_vcftools

module load bioinfo-tools vcftools/0.1.16

vcftools --vcf ../../04_genotype_likelihood/03_SCP/01_SCP.vcf  \
--TajimaD 5000 --out 02_SCP80_1e6_vcftools_win5kb
