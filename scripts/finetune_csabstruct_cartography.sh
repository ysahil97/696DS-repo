#!/bin/bash
#SBATCH -c 2  # Number of Cores per Task
#SBATCH --mem=50GB  # Requested Memory
#SBATCH -p gypsum-titanx  # Partition
#SBATCH -G 1  # Number of GPUs
#SBATCH -t 02:00:00  # Job time limit
#SBATCH -o ./logs/slurm-%j.out  # %j = job ID

# load conda
module load conda

# activate vadops env
conda activate /work/pi_adrozdov_umass_edu/$USER/envs/vadops

# Argument 1(checkpoints_out_dir): specify filepath where you want finetuning checkpoint to be saved
# Argument 2(cartography_split): Specify the dataset split from ['train', 'dev']
# Argument 3(log_training_dynamics_dir): specify the dir path to store the training dynamics
python ../models/CSAbstruct.py finetune $1 True $2 $3

# Example
# Using python: python ../models/CSAbstruct.py finetune /path/to/checkpoint True {cartography_split} {log_training_dynamics_dir}
# Using python: python ../models/CSAbstruct.py finetune ../checkpoints/csabstruct True train ../training_dynamics/csabstruct

# Using bash: sbatch finetune_csabstruct_cartography.sh /path/to/checkpoint {cartography_split} {log_training_dynamics_dir}
# Using bash: sbatch finetune_csabstruct_cartography.sh ../checkpoints/csabstruct train ../training_dynamics/csabstruct
