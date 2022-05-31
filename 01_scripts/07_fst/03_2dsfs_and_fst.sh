#!/bin/bash
#SBATCH -A snic2022-5-25
#SBATCH -p node
#SBATCH -n 8
#SBATCH -t 1-12:00:00
#SBATCH --mail-user=ya2100hu-s@student.lu.se
#SBATCH --mail-type=FAIL
#SBATCH -o 07_fst/04_fst_new/00_error_files/04_2dsfs_and_fst.out
#SBATCH -e 07_fst/04_fst_new/00_error_files/04_2dsfs_and_fst.err
#SBATCH -J 2d-SFS
#SBATCH -D /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd

module load bioinfo-tools ANGSD/0.933

realSFS 07_fst/04_fst_new/01_saf/02_SCH.saf.idx \
07_fst/04_fst_new/01_saf/03_SCP.saf.idx \
-fold 1 -nSites 200000000 -P 8 > 07_fst/04_fst_new/02_2dsfs/SCH_SCP.sfs


awk 'BEGIN{FS=OFS=" "}
NR>=1{for (i=1;i<=NF;i++) a[i]+=$i}
END{for (i=1;i<=NF;i++) printf ("%f ",a[i]); printf "\n"}' 07_fst/04_fst_new/02_2dsfs/SCH_SCP.sfs > 07_fst/04_fst_new/02_2dsfs/SCH_SCP_sum.sfs

realSFS fst index 07_fst/04_fst_new/01_saf/02_SCH.saf.idx \
07_fst/04_fst_new/01_saf/03_SCP.saf.idx \
-sfs  07_fst/04_fst_new/02_2dsfs/SCH_SCP_sum.sfs \
-fstout  07_fst/04_fst_new/03_fst/00_SCH_SCP \
-fold 1 -P 8

realSFS fst stats 07_fst/04_fst_new/03_fst/00_SCH_SCP.fst.idx \
-fold 1 > 07_fst/04_fst_new/03_fst/01_SCH_SCP_overall.fst

realSFS fst stats2 07_fst/04_fst_new/03_fst/00_SCH_SCP.fst.idx \
-win 5000 -step 1000 -type 2 -fold 1 \
-P 8 > 07_fst/04_fst_new/03_fst/02_SCH_SCP_win5kb.fst
