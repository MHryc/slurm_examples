#!/bin/bash

# === Slurm Parameters ===

#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH -p fast
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB

#SBATCH --array=1-16

export SLURM_CPUS_PER_TASK

# === Select values from config using SLURM_ARRAY_TASK_ID ===

# path to config
CONFIG="${SLURM_SUBMIT_DIR}/config.conf"

# we can read whole row from config as an array
readarray -t ARR < <(awk -v \
	TASK_ID=$SLURM_ARRAY_TASK_ID \
	'$1 == TASK_ID' $CONFIG)

# or just a single value
export filename=$(awk -v TASK_ID=$SLURM_ARRAY_TASK_ID \
	'$1 == TASK_ID {print $3}' $CONFIG)

# === Run Commands ===

# print values from each column to std Out

echo "==> Itererating over all row values <=="

len=${#arr[@]}
for (( i=0; i<$len; i++ )); do
	echo "${arr[$i]}"
done

echo "==> Just a single caputer value <=="

echo "Filename is $filename"
