#!/bin/bash
#SBATCH -A snic2020-5-582
#SBATCH -p node
#SBATCH -n 20
#SBATCH -t 20:00:00
#SBATCH --mail-user=ya2555ch-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o mapping1.out
#SBATCH -e mapping1.err
#SBATCH -J mapping
#SBATCH -D /proj/snic2020-6-222/Chao/project2021/

module load bioinfo-tools bwa/0.7.17

bwa mem -M -t 20 \
-R @RG\tID:P18751_1082.AHGMMCDSXY.L001\tPL:Illumina\tLB:P18751_1082
/proj/snic2020-6-222/Chao/project2021/data/ref_genome/pt_042_hifiasm20201214.primary.fasta
/proj/snic2020-6-222/Projects/Tconura/data/WGS/rawdata/P18751/P18751/P18751_1082/02-FASTQ/201204_A00187_0397_AHGMMCDSXY/P18751_1082_S1_L001_R1_001.fastq.gz
/proj/snic2020-6-222/Projects/Tconura/data/WGS/rawdata/P18751/P18751/P18751_1082/02-FASTQ/201204_A00187_0397_AHGMMCDSXY/P18751_1082_S1_L001_R2_001.fastq.gz
