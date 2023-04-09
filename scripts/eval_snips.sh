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

# Argument 1(checkpoints_out_dir): specify finetuning checkpoint filepath you wanna load
# Argument 2(predictions_out_dir): Specify the filepath to save the predictions with the .csv extension to ensure OS 
# understandability, as the pd.to_csv() method converts the data into a CSV format but does not save it with the .csv file extension.
python ../models/SNIPS.py eval $1 $2

# Examples
# Using python: python ../models/SNIPS.py eval /path/to/checkpoint /path/to/prediction/{fileName}.csv
# Using python: python ../models/SNIPS.py eval ../checkpoints/snips/checkpoint-26170/ ../predictions/snips.csv

# Using bash: sbatch eval_snips.sh /path/to/checkpoint /path/to/prediction/{fileName}.csv
# Using bash: sbatch eval_snips.sh ../checkpoints/snips/checkpoint-26170/ ../predictions/snips.csv

