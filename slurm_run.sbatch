#!/bin/bash
#SBATCH -J main_table                           # Job name
#SBATCH --account=gts-rs275-paid                # charge account
#SBATCH -N 1 --gres=gpu:RTX_6000:2              # Number of nodes and cores per node required
#SBATCH --mem-per-gpu=24G                       # Memory per core
#SBATCH -t 1440                                 # Duration of the job (Ex: 15 mins)
#SBATCH -q inferno                              # QOS Name
#SBATCH -o Report-%j.out                        # Combined output and error messages file
#SBATCH --mail-type=BEGIN,END,FAIL              # Mail preferences
#SBATCH --mail-user=cchen847@gatech.edu         # E-mail address for notifications
cd $SLURM_SUBMIT_DIR                            # Change to working directory

module load anaconda3/2022.05                   # Load module dependencies
conda create -n bm ipython python=3.8 -y
conda activate bm
conda install pytorch=2.0.1 torchaudio=2.0.2 cudatoolkit=11.3 -c pytorch -y
pip install -U -r requirements.txt
pip install -e .
dora grid nmi.main_table
