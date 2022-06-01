
## Host plant driven genomic differentiation during the early stages of population divergence in the peacock fly *Tephritis conura*
### Yajuan Huang
### May 2022

Code is available on: <https://github.com/YajuanHuang/Popstructure_Tephritisconura>

## Description
Using the ANGSD pipeline to estimate population structure and genetic diversity of the peacock fly *Tephritis conura*

The scripts ran on the Swedish National Infrastructure for Computing (SNIC), in the UPPMAX centre (<https://www.uppmax.uu.se>).

#### Required programs:
- ANGSD/0.933 (<http://www.popgen.dk/angsd/index.php/ANGSD#Overview>)
- VCFtools/0.1.16 (<https://vcftools.github.io/index.html>)
- plink/1.90b4.9 (<https://www.cog-genomics.org/plink/>)
- ADMIXTURE/1.3.0 (<http://dalexander.github.io/admixture/>)
- SweeD (<https://cme.h-its.org/exelixis/web/software/sweed/>)
- Python/3.6.5
- R/4.1.1

#### Note:
Remeber to modify .sh files to set the working directory, edit the number of cpu and allocate memory/time.

## 01_Data
Data are stored in UPPMAX, the directory is */proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd*, including reference genome and bam files of Scottish individuals and outgroup individuals.

## 02_List_bamfiles
Listing the bam files of all individuals and by populations.
- The working directory: */proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/00_data*
- Scottish individuals
  `ls *bam > ../02_info/01_scotland_bam.list`
- SCH pop individuals
  `ls SCH* > ../02_info/02_SCH_bam.list`
- SCP pop individuals
  `ls SCP* > ../02_info/03_SCP_bam.list`

## 03_Genotype_likelihood
The following scripts will work on the bam files and calculate maf, saf and genotype likelihood of Scottish, SCH and SCP populations, using ANGSD(v0.933).
**Note:** If you want to get the vcf format, you should add the parameter: `-doBcf 1`, you will get the vcf format result for further analysis.(The suffix of the file is .bcf, but it is actually a vcf format file)
- 3.1 Scotland
  - Working directory
    - /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/
  - Submit: `sbatch 01_script/04_genotype_likelihood/01_gl_scotland80.sh`
  - Arguements:
    - **-minInd 25** : The whole number of scotland population is 31, set it at 80% of the whole number. 31*0.8=24.8~25
    - **-setMinDepth 76** : Discard the site if the total sequencing depth is below the threshold. As a rule of thumb: 0.2*coverage*n. The n is 31, and the coverange is 12.295, set it to 0.2*coverage*n=0.2*12.295*31=76.299~76
    - **-setMaxDepth 762** # Discard the site if the total sequencing depth is above the threshold. As a rule of thumb, I used 2*coverage*n. The n is 31, and the coverange is 12.295, so i set it to 2*coverage*n=2*12.295*31=762

- 3.2 SCH
  - Submit: `sbatch 01_script/04_genotype_likelihood/02_gl_SCH.sh`
  - Arguements:
    - **-minInd 13** : The whole number of scotland population is 16, set it at 80% of the whole number. 16*0.8=~13
    - **-setMinDepth 37** : Discard the site if the total sequencing depth is below the threshold. As a rule of thumb: 0.2*coverage*n. The n is 16, and the coverange is 12.295, set it to 0.2*coverage*n=0.2*12.295*16=37
    - **-setMaxDepth 762** # Discard the site if the total sequencing depth is above the threshold. As a rule of thumb, I used 2*coverage*n. The n is 16, and the coverange is 12.295, so i set it to 2*coverage*n=2*12.295*16=370

- 3.3 SCP
  - Submit: `sbatch 01_script/04_genotype_likelihood/03_gl_SCP.sh`
  - Arguements:
    - **-minInd 12** : The whole number of scotland population is 15, set it at 80% of the whole number. 31*0.8=24.8~25
    - **-setMinDepth 39** : Discard the site if the total sequencing depth is below the threshold. As a rule of thumb: 0.2*coverage*n. The n is 15, and the coverange is 12.295, set it to 0.2*coverage*n=0.2*12.295*15=39
    - **-setMaxDepth 392** # Discard the site if the total sequencing depth is above the threshold. As a rule of thumb, I used 2*coverage*n. The n is 15, and the coverange is 12.295, so i set it to 2*coverage*n=2*12.295*15=392

## 04_LD_prune
Using the plink to perform LD prune(v1.90b4.9).
- 4.1 Working directory
  - /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/04_genotype_likelihood/01_scotland
- 4.2 Convert file format (.vcf to .ped)
  - `sbatch 01_script/05_PCA/06_LD_plink/05_vcf2ped.sh`
- 4.3 LD-prune
  - `sbatch 01_script/05_PCA/06_LD_plink/04_plink_LD_prune_50SNPs0.1.sh`
- 4.4 Keep the SNPs in .in file
  - `awk 'NR==FNR{a[$1];next}$1 in a' ../../05_scotland80_1e6_pruned.prune.in 01_scotland80.beagle > 11_scotland80_1e6_pruned.beagle`
    - using the first column of the first file to generate a array
    - if the first column is in the second file, print this line to the new file

## 05_PCA
Using the PCAngsd to perform principal component analysis (PCA).
- 5.1 Working directory
  - /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd/05_PCA/05_LD_plink
- 5.2 Compress the .beagle file
  - `gzip 11_scotland80_1e6_pruned.beagle`
- 5.3 PCA
  - `sbatch 01_script/05_PCA/01_scotland80_pca.sh`

## 06_Admixture_analysis
Using ADMIXTURE(v1.3.0) to perform clustering  analysis.
`sbatch 01_script/06_admix/04_Admixture/03_scotland80_1e6_pruned_K12345.sh`

## 07_FST
Using the ANGSD(v0.933) to estimate FST.
- `sbatch 01_script/07_fst/04_new_fst/03_2dsfs_and_fst.sh`

## 08_Dxy
Dxy was calculated from .maf files, in sliding window with the window size of 5k bp and step size 1k bp, using the script developed by Julio Ayala (<https://github.com/julioaayala/popstructure_italiansparrow/tree/main/Bin/dxy_maf.py>).
- 8.1 Working directory
  - /proj/snic2020-6-222/Projects/Tconura/working/Yajuan/003_new_angsd
- 8.2 Split .maf file
  - SCH
    - Load module: `module load bioinfo-tools python/3.9.5`
    - Spliting .mafs file: `python3 01_script/08_dxy/01_split_mafs.py \
    -i 04_genotype_likelihood/02_SCH/02_SCH.mafs \
    -o 04_genotype_likelihood/02_SCH/00_split_mafs`
  - SCP
    - Load module: `module load bioinfo-tools python/3.9.5`
    - Spliting .mafs file: `python3 01_script/08_dxy/01_split_mafs.py \
    -i 04_genotype_likelihood/03_SCP/01_SCP.mafs \
    -o 04_genotype_likelihood/03_SCP/00_split_mafs`
- 8.3 Calculate dxy
  `sbatch 01_script/08_dxy/04_SCH_SCP_dxy5kb.sh`
- 8.4 Concatenate contigs
  `cat *.dxy | cut -f 1-5 > 01_merged_dxy_win5kb.dxy`

## 09_Tajima's D
Using VCFtools (v 0.1.16) to estimate Tajima's D for each population.
- 9.1 SCH
  `sbatch 01_script/09_TajimasD/03_TajimasD_SCH_5kb_vcftools.sh`
- 9.2 SCP
  `sbatch 01_script/09_TajimasD/04_TajimasD_SCP_5kb_vcftools.sh`

## 10_Pi(π)
Using VCFtools (v 0.1.16) to calculate Pi(π) for each population.
- 10.1 SCH
  `sbatch 01_script/10_Pi/01_SCH_vcftools_pi_win5kb.sh`
- 10.2 SCP
  `sbatch 01_script/10_Pi/02_SCP_vcftools_pi_win5kb.sh`

## Plotting
The plotting scripts are in *01_scripts/RScrpits* folder.

## Contact
<ya2100hu-s@student.lu.se>
