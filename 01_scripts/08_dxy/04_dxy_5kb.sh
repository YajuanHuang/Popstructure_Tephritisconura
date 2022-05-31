#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 5
#SBATCH -t 10:00:00
#SBATCH --mail-user=yajuan_huang@outlook.com
#SBATCH --mail-type=FAIL
#SBATCH -e 08_dxy/00_error_files/04_SCH_SCP_dxy5kb.err
#SBATCH -o 08_dxy/00_error_files/04_SCH_SCP_dxy5kb.out
#SBATCH -J dxy5kb
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd

module load bioinfo-tools python/3.9.5

for chr in 02_info/05_contig_names.list; do \
01_script/08_dxy/03_maf_dxy.py \
--pop1 04_genotype_likelihood/02_SCH/00_split_mafs/02_SCHs.${chr}.maf \
--pop2 04_genotype_likelihood/03_SCP/00_split_mafs/01_SCPs.${chr}.maf \
--window 5000 --step 1000 > 08_dxy/01_dxy/SCH_SCP_${chr}_window5kb.dxy; done
