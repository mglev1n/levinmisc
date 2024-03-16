#!/bin/bash

# Set default values for command line arguments
num_cpus=1
job_name="make_targets"
output_log="build_logs/targets_%J.out"
error_log="build_logs/targets_%J.err"
queue="voltron_normal"
memory="16000"
job_script=$(pwd)"/.make-targets.sh"
slack=false

# Parse command line arguments
while getopts ":n:j:o:e:q:m:s:h" opt; do
    case $opt in
        n)
            num_cpus=$OPTARG
            ;;
        j)
            job_name=$OPTARG
            ;;
        o)
            output_log=$OPTARG
            ;;
        e)
            error_log=$OPTARG
            ;;
        q)
            queue=$OPTARG
            ;;
        m)
            memory=$OPTARG
            ;;

        s)
            slack=$OPTARG
            ;;
        h)
            echo "Usage: $0 [-n NUM_CPUS] [-j JOB_NAME] [-o OUTPUT_LOG] [-e ERROR_LOG] [-q QUEUE] [-m MEMORY] [-s SLACK] [-h HELP]"
            echo
            echo "Submit a job using the LSF scheduler with the specified number of CPUs and memory usage."
            echo
            echo "Options:"
            echo "  -n NUM_CPUS    Number of CPUs to request for the job (default: 1)"
            echo "  -j JOB_NAME    Name of the job (default: make_targets)"
            echo "  -o OUTPUT_LOG  Path to the output log file (default: build_logs/targets_%J.out)"
            echo "  -e ERROR_LOG   Path to the error log file (default: build_logs/targets_%J.err)"
            echo "  -q QUEUE       Name of the queue to submit the job to (default: voltron_normal)"
            echo "  -m MEMORY      Memory usage for the job in megabytes (default: 16000)"
            echo "  -s SLACK       Enable slack notifications; requires setup using slackr::slack_setup() (default: false)"
            echo "  -h HELP        Display this help message and exit"
            echo
            echo
            exit 0
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

# Shift command line arguments to skip parsed options
shift $((OPTIND-1))

# Submit job to LSF scheduler with specified number of CPUs and arguments
bsub -cwd $(pwd) -J $job_name -o $output_log -e $error_log -q $queue -R "rusage[mem=$memory]" <<EOF
$job_script -n $num_cpus -s $slack
EOF

# Prompt user to monitor job status
echo ""
echo "Submitted the main {targets} process <$job_name> to <$queue>, and requested $num_cpus workers"
echo "Worker-specific parameters (eg. cores, memory, and queue for each worker) should be specified within the {targets} pipeline."
echo ""
read -p "Would you like to monitor the job status? (y/n): " answer
if [[ $answer =~ ^[Yy][Ee][Ss]|[Yy]$ ]]; then
    watch bjobs -W
else
    exit
fi
