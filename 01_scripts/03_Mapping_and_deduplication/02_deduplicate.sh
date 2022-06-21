#!/bin/bash
#SBATCH -A snic2020-5-582
#SBATCH -p node
#SBATCH -n 20
#SBATCH -t 20:00:00
#SBATCH --mail-user=ya2555ch-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o deduplication1.out
#SBATCH -e deduplication1.err
#SBATCH -J deduplication
#SBATCH -D /proj/snic2020-6-222/Chao/project2021/data/bam/raw_bam


module load bioinfo-tools picard/2.23.4 gnuparallel/20180822;
BamList="merged_bam.list"
export BamList


deduplicate() {
	sample="$1"
	base=$(awk 'BEGIN{FS="."}{print $1}' <<< "$sample")
	java -jar "$PICARD_ROOT"/picard.jar MarkDuplicates \
	-I "$sample" \
	-O "$base".deduplicated.bam \
	-METRICS_FILE "$base"_dedpuliacte.metrics \
	-VALIDATION_STRINGENCY LENIENT \
	-ASSUME_SORT_ORDER coordinate \
	-CREATE_INDEX TRUE \
	-REMOVE_DUPLICATES TRUE
	echo "$sample"
} ;

export -f deduplicate;

parallel --memfree 30G -j3 \
--tmpdir /proj/snic2020-6-222/Chao/project2021/data/tmp \
-a "$BamList" deduplicate
