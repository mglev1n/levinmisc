#!/bin/bash

# Runs the main {targets} process against the LPC's native R rather than inside
# the RStudio Singularity container. crew launches the workers from within the
# pipeline itself, so this script only has to put the right R on PATH; the
# project library then follows from renv/activate.R, because the job runs in the
# project directory.

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
    echo "Usage: $0 [-n NUM_CPUS] [-s true/false]"
    exit 1
fi

# num_cpus is accepted so that submit-targets.sh can pass it unconditionally,
# but crew takes its worker counts from the controllers defined in the pipeline,
# so it is not used here.

module load R/4.5

export TMPDIR=/scratch
export R_WORK_DIR=$(pwd)

if $slack; then
  R --no-save --no-restore -e "slackr::slackr_setup(); slackr::slackr_bot('Targets Pipeline Started'); targets::tar_make(); slackr::slackr_bot('Targets Pipeline Complete')"
else
  R --no-save --no-restore -e "targets::tar_make()"
fi
