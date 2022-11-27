#!/bin/bash

#BSUB-J make-targets                      # name of the job / array jobs
#BSUB-n 1                                 # number of cores to use per job
#BSUB-o build_logs/targets_%J.out         # stdout + stderr; %I for array index
#BSUB-e build_logs/targets_%J.err         # stdout + stderr; %I for array index
#BSUB-M 32000                             # Memory requirements in Mbytes
#BSUB-R rusage[mem=32000]                 # Memory requirements in Mbytes
#BSUB-q damrauer_normal                   # name of the queue (uncomment)

export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.0
export SINGULARITY_BIND="/project/PMBB/:/project/PMBB/, /scratch/:${HOME}/roubaix/scratch/"

module load singularity/3.8.3

ulimit -v $(( 1024 * 32000))

singularity exec /project/damrauer_shared/rstudio/bioconductor-tidyverse_singularity-latest.sif R --no-save --no-restore -e 'targets::tar_make_clustermq(workers = 10)'
