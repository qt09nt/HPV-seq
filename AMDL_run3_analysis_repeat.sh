#!/bin/bash 
#SBATCH -p all # partition (queue)  
#SBATCH -N 1 # number of nodes  
#SBATCH --ntasks-per-node=1 # number of tasks  
#SBATCH --cpus-per-task=1 # number of cores  
#SBATCH --mem=2G # memory pool for all cores  
#SBATCH -t 2-00:00:00 # time (D-HH:MM)  
#SBATCH -o slurm.%x.%j.out # STDOUT  
#SBATCH -e slurm.%x.%j.err # STDERR 

module load java
module load singularity

. ~/.bashrc # conda init

conda activate nextflow_env
export NXF_OFFLINE='true'
# export COLUMNS=200

#cd /cluster/projects/scottgroup/people/jinfeng/HPV-seq/AMDL_run3
cd /cluster/projects/uhnclg/HPV-seq/AMDL_run3_analysis_repeat
#hpvseqdir=/cluster/home/jfzou/BratmanLab-ctDNA-Seq/nextflow/hpvseq
hpvseqdir=/cluster/projects/uhnclg/HPV-seq/13Jan2026/HPV-seq_pipeline
#yml_cohort=params_AMDL_run3.yml
yml_cohort=/cluster/projects/uhnclg/HPV-seq/AMDL_run3_analysis_repeat/params_AMDL_run3_repeat_analysis.yml

nextflow run $hpvseqdir/main.nf -profile singularity -c $hpvseqdir/conf/hpvseq.config -c $hpvseqdir/conf/hpcgenomes.config -params-file $yml_cohort -resume
# -ansi-log false 
~                  
