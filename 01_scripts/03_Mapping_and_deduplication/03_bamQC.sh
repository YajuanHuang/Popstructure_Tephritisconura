#!/bin/bash
#SBATCH -A snic2020-5-582
#SBATCH -p node
#SBATCH -n 20
#SBATCH -t 20:00:00
#SBATCH --mail-user=ya2555ch-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o bamQC.out
#SBATCH -e bamQC.err
#SBATCH -J bamQC
#SBATCH -D /proj/snic2020-6-222/Chao/project2021/data/bam/raw_bam


module load bioinfo-tools  QualiMap/2.2.1 gnuparallel/20180822
unset DISPLAY

BamList=cov_bam.list
export BamList

BamQC() {
sample="$1"
prefix=$( basename -s .deduplicated.bam "$sample")
qualimap bamqc \
  -bam $sample \
  -outdir "./bamQC/${prefix}/" \
  -nt 5 \
  --java-mem-size=32G >& "${prefix}-qualimap.log"
} ;

export -f BamQC;

parallel -j4 --tmpdir /proj/snic2020-6-222/Chao/project2021/data/tmp -a "$BamList" BamQC
