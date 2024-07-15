#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --mem=24G
#SBATCH --output=simulation.out
#SBATCH --gpus=2

module load matlab srun matlab -nodisplay -nosplash -batch run_all

