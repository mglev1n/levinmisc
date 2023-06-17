#!/bin/bash

# Initialize variables with default values
slack=false
num_cpus=1

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            shift
            num_cpus=$1
            ;;
        -s)
            shift
            if [[ "$1" == "true" ]]; then
                slack=true
            fi
            ;;
        *)
            echo "Usage: $0 [-n NUM_CPUS] [-s true/false]"
            exit 1
            ;;
    esac
    shift
done

# Check that the required arguments were provided
if [[ -z "$num_cpus" ]]; then
    echo "Usage: $0 [-n NUM_CPUS] [-run_script1 true/false]"
    exit 1
fi

export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.0
export SINGULARITY_BIND="/project/PMBB/:/project/PMBB/, /scratch/:${HOME}/scratch/"
export R_WORK_DIR=$(pwd)

module load singularity

ulimit -v $(( 1024 * 32000))

export SINGULARITYENV_APPEND_PATH=${PATH}

if $slack; then
  singularity exec --bind $(pwd)/ /project/voltron/rstudio/bioconductor-tidyverse_singularity-latest.sif R --no-save --no-restore -e "slackr::slackr_setup(); slackr::slackr_bot('Targets Pipeline Started'); targets::tar_make_clustermq(workers = $num_cpus); slackr::slackr_bot('Targets Pipeline Complete')"
else
  singularity exec --bind $(pwd)/ /project/voltron/rstudio/bioconductor-tidyverse_singularity-latest.sif R --no-save --no-restore -e "targets::tar_make_clustermq(workers = $num_cpus)"
fi
