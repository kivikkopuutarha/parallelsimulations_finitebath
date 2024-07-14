#!/bin/bash
#SBATCH --time=02:00:00
#SBATCH --mem=24G
#SBATCH --output=simulation.out
#SBATCH --cpus-per-task=1
#SBATCH --partition=gpu-h100-80g --gpus=1

module load matlab

srun matlab -nodisplay -nosplash -batch run_all