#!/bin/bash
#SBATCH --job-name=com2sense_unifiedqa_t5_3b
#SBATCH --output ./slurm_logs/output_test_unifiedqa_t5_3b.log
#SBATCH --error ./slurm_logs/error_test_unifiedqa_t5_3b.log
#SBATCH --partition gpu
#SBATCH --mem=64G          
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
source /lustre/home/pghoshlab/adv_nlp/.venv/bin/activate

# Run Python script
python3 main.py \
--mode test \
--ckpt ./model_weights/unifiedqa_3b_trained_on_official_train.pth \
--model allenai/unifiedqa-t5-3b \
--dataset com2sense \
--test_file dev \
--batch_size 32

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
