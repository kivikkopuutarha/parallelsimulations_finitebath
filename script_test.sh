#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --mem=16G
#SBATCH --output=simulation.out
#SBATCH --partition=gpu-debug --gpus=1

module load matlab

srun matlab -nodisplay -nosplash -batch run_all