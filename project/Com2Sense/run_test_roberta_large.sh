#!/bin/bash
#SBATCH --job-name=com2sense_roberta
#SBATCH --output output_test_roberta_large.log
#SBATCH --error error_test_roberta_large.log
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

# Activate Python environment
source activate /lustre/home/pghoshlab/adv_nlp/.venv/bin/python3

# Run Python script
CUDA_LAUNCH_BLOCKING=1 python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/roberta_large/bs_16/ep_1_stp_101_acc_50.3906_roberta_large.pth \
--model roberta-large \
--dataset com2sense \
--batch_size 32

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
