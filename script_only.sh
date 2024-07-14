#!/bin/bash
#SBATCH --time=02:00:00
#SBATCH --mem=128G
#SBATCH --output=simulation.out
#SBATCH --cpus-per-task=40

module load matlab

srun matlab -nodisplay -nosplash -batch run_all