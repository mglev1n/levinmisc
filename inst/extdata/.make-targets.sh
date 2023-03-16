#!/bin/bash

# Parse command line arguments
while getopts "n:w" opt; do
    case $opt in
        n)
            num_cpus=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done


export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.0
export SINGULARITY_BIND="/project/PMBB/:/project/PMBB/, /scratch/:${HOME}/scratch/"
export R_WORK_DIR=$(pwd)

module load singularity/3.8.3

ulimit -v $(( 1024 * 32000))

echo $(pwd)

singularity exec --bind $(pwd)/ \
  /project/voltron/rstudio/bioconductor-tidyverse_singularity-latest.sif R --no-save --no-restore -e "slackr::slackr_setup(); slackr::slackr_bot('Targets Pipeline Started', channel = '@Mike Levin'); targets::tar_make_clustermq(workers = $num_cpus); slackr::slackr_bot('Targets Pipeline Complete', channel = '@Targets')"
