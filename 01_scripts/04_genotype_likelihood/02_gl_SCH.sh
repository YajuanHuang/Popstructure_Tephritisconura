#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 10
#SBATCH -t 2-10:00:00
#SBATCH --mail-user=yajuan_huang@outlook.com
#SBATCH --mail-type=FAIL
#SBATCH -e 04_genotype_likelihood/00_error_files/04_SCH_second_time.err
#SBATCH -o 04_genotype_likelihood/00_error_files/04_SCH_second_time.out
#SBATCH -J SCH_maf2
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd

module load bioinfo-tools ANGSD/0.933

angsd -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMaf 0.05 -minMapQ 30 -minQ 20 -GL 1 -doMaf 1 -dosaf 1 -doGlf 2 -doGeno 4 \
-doPost 1 -doBcf 1 -doMajorMinor 1 -doCounts 1 -P 10 \
-ref 00_data/00_reference_genome/pt_042_hifiasm20201214.primary.fasta \
-anc 00_data/00_reference_genome/pt_042_hifiasm20201214.primary.fasta \
-b 02_info/02_SCH_bam.list \
-out 04_genotype_likelihood/02_SCH/02_SCH_second_time \
-minInd 13 -setMinDepth 37 -setMaxDepth 370 -SNP_pval 1e-6
