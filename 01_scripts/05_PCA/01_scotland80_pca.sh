#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 5
#SBATCH -t 01:00:00
#SBATCH --mail-user=yajuan_huang@outlook.com
#SBATCH --mail-type=FAIL
#SBATCH -J PCA
#SBATCH -o 05_PCA/00_error_files/01_Scotland80_pca.out
#SBATCH -e 05_PCA/00_error_files/01_Scotland80_pca.err
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd

module load bioinfo-tools PCAngsd/0.982

pcangsd.py \
-beagle 04_genotype_likelihood/01_scotland/11_scotland80.beagle.gz -threads 2 \
-o 05_PCA/01_scotland
