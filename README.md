# Parallel Simulations, Finite Bath
## Description
A collection of MATLAB functions and scripts to simulate the time evolution of a finite spin bath coupled to a qubit.

The collection is optimised for parallel computations of three different types:

- [ ] Vectorisation only, for usage in single CPU, without GPU [modular](#Modular)
- [ ] Multicore, for usage in a single supercomputer node with multiple CPUs and shared RAM, without GPU [multicore](#Multicore)
- [ ] GPU, for usage in single CPU, with GPU [GPU](#GPU)

## Installation
Besides the [requirements](https://version.aalto.fi/gitlab/tsiorms1/parallelsimulations_finitebath/-/raw/main/requirements.txt), no other software is required to run the simulation. It is advised to clone the present repository directly using git:
```
git clone git@version.aalto.fi:tsiorms1/parallelsimulations_finitebath.git
```
# Usage
The type of parallelisation used is defined inside the running MATLAB script run_all.m
```
16   % Define parallelisation type. Accepted values are 'modular', 'GPU',
17   % 'multicore'.
18   type = 'modular';
```
The simulation can run both in personal computers and in supercomputer clusters, utilising a single node only.

To run the simulation in [Aalto's Triton cluster](https://scicomp.aalto.fi/triton/), after cloning the repository, copy the provided testing sbatch script (script.sh) at your home folder:
```
/home/{USERNAME}
```
and edit it to modify the specifications of the hardware as needed.

The specifications of the simulation are defined in the MATLAB script run_all.m which is located in the scr folder:
```
/home/{USERNAME}/parallelsimulations_finitebath/src
```
Read carefully the comments on the code before you modify the specifications of the simulation.

The sbatch script should be called from inside the src folder, with:
```
sbatch ~/script.sh
```

# Parallelisation types

## Modular
In this mode, the code is vectorised for usage with single CPU.

## Multicore
In this mode, the vectorised code is utilising the Parallel Computing Toolbox for usage of multiple CPU cores.

## GPU
In this mode, the vectorised code is utilising the Parallel Computing Toolbox for usage of GPU.

## Support
If you need help on running this simulation, please contact with the author by [email](mailto:stergios.tsiormpatzis@aalto.fi)

## Authors and acknowledgment
The code collection for this simulation is the work of Stergios Tsiormpatzis. The original code as used without parallelisation and modular optimisation was kindly provided by Ilari Mäkinen.

## License
[MIT license](https://opensource.org/license/mit)

## Project status
This repository is the product of a Bachelor Thesis and will be finalised in Autumn 2024. Further development and improvements are welcomed!
