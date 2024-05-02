#!/bin/bash
#SBATCH --job-name=com2sense_deberta
#SBATCH --output ./slurm_logs/output_train_deberta_large.log
#SBATCH --error ./slurm_logs/error_train_deberta_large.log
#SBATCH --partition gpu
#SBATCH --mem=32G  
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
source activate /lustre/home/pghoshlab/adv_nlp/.venv/bin/python3

# Run Python script
python3 main.py --mode train \
--expt_dir ./results_log/com2sense \
--expt_name deberta_large \
--model microsoft/deberta-large \
--dataset com2sense \
--run bs_32 \
--batch_size 32 \
--seq_len 128

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
