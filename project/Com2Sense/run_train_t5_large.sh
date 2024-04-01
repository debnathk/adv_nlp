#!/bin/bash
#SBATCH --job-name=com2sense_t5_large
#SBATCH --output output_train_t5_large.log
#SBATCH --error error_train_t5_large.log
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
source activate /lustre/home/debnathk/adv_nlp/.venv/bin/python3

# Run Python script
python3 main.py \
--mode train \
--expt_dir ./results_log/_multi_data/wgd_cqa \
--expt_name t5_large \
--model t5-large \
--dataset com2sense  \
--run bs_8 \
--batch_size 8 \
--seq_len 128 \
--use_amp F

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
