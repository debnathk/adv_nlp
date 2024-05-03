#!/bin/bash
#SBATCH --job-name=com2sense_xlnet-base
#SBATCH --output ./slurm_logs/output_test_xlnet-base.log
#SBATCH --error ./slurm_logs/error_test_ernie_xlnet-base.log
#SBATCH --partition gpu
#SBATCH --mem=16G          
#SBATCH --gres=gpu:1

echo "Date"
date

start_time=$(date +%s)

# Load the necessary modules
# module purge
module load cuda/12.3  # Change this to the appropriate CUDA version
# module load cudnn/8.0.4   # Change this to the appropriate cuDNN version
# module load anaconda/2020.11  # Change this to the appropriate Anaconda version
# module load anaconda3

# Activate Python environment
source /lustre/home/pghoshlab/adv_nlp/.venv/bin/activate # replace this line to activate your own virtual/conda environment

# Run Python script
python3 main.py \
--mode test \
--model xlnet/xlnet-base-cased \
--dataset com2sense \
--test_file dev \
--batch_size 32

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
