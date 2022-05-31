#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 3-10:00:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o ../07_fst/04_fst_new/00_error_files/02_saf_SCP.out
#SBATCH -e ../07_fst/04_fst_new/00_error_files/02_saf_SCP.err
#SBATCH -J Saf_SCP
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/00_data

module load bioinfo-tools ANGSD/0.933

REF=00_reference_genome/pt_042_hifiasm20201214.primary.fasta
bam=../02_info/03_SCP_bam.list
n_ind=$(cat ../02_info/03_SCP_bam.list | wc -l) # The Result shows 15
minDep=$((4*$n_ind))
minind=$(printf "%.0f\n" ($n_ind/2)) #SCH population cotain odd number of individuals.
file_name=$(basename "$bam" _bam.list) # the result is 03_SCP
out=../07_fst/04_fst_new/01_saf/"$file_name"
mean_cov=13.077
maxDep_raw=$(echo 2*"$mean_cov"*"$n_ind"|bc)
maxDep=$(printf "%.0f\n" $maxDep_raw)


angsd -b $bam \
-ref $REF -anc $REF -out $out \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 30 -minQ 20 -minInd $minind -setMinDepth $minDep -setMaxDepth $maxDep -doCounts 1  \
-GL 1 -doSaf 1 -P 6
