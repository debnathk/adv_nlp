#!/bin/bash
#SBATCH --job-name=com2sense_all
#SBATCH --output ./slurm_logs/output_test_all.log
#SBATCH --error ./slurm_logs/error_test_all.log
#SBATCH --partition gpu
#SBATCH --mem=32G          
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task 16

module load cuda/12.3  # Change this to the appropriate CUDA version
# module load cudnn/8.0.4   # Change this to the appropriate cuDNN version
# module load anaconda/2020.11  # Change this to the appropriate Anaconda version

# Activate Python environment
source activate /lustre/home/pghoshlab/adv_nlp/.venv/bin/python3 # replace this line to activate your own virtual/conda environment

############################
#    ROBERTA-LARGE         #
############################

# roberta-large batch size 16 after finetuning 
echo roberta-large batch size 16 after finetuning

python3 main.py \
--mode test \
--model roberta-large --dataset com2sense --test_file dev --batch_size 16 --num_workers 4 

# roberta-large batch size 16 after finetuning 
echo roberta-large batch size 16 after finetuning

python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/roberta_large/bs_16/ep_15_stp_1.5k_acc_50.6510_roberta_large.pth \
--model roberta-large --dataset com2sense --test_file dev --batch_size 16 --num_workers 4 

# roberta-large batch size 32 before finetuning 
echo roberta-large batch size 32 before finetuning

python3 main.py \
--mode test \
--model roberta-large --dataset com2sense --test_file dev --batch_size 32 --num_workers 4 

# roberta-large batch size 32 after finetuning
echo roberta-large batch size 32 after finetuning
 
python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/roberta_large/bs_32/ep_74_stp_3.7k_acc_62.3698_roberta_large.pth \
--model roberta-large --dataset com2sense --test_file dev --batch_size 32 --num_workers 4 



############################
#    DEBERTA-LARGE         #
############################

# deberta-large batch size 16 before finetuning
echo deberta-large batch size 16 before finetuning

python3 main.py \
--mode test \
--model microsoft/deberta-large --dataset com2sense --test_file dev --batch_size 16 --num_workers 4

# roberta-large batch size 16 after finetuning 
echo deberta-large batch size 16 after finetuning

python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/deberta_large/bs_16/ep_24_stp_2.4k_acc_68.0990_microsoft_deberta_large.pth \
--model microsoft/deberta-large --dataset com2sense --test_file dev --batch_size 16 --num_workers 4

# deberta-large batch size 32 before finetuning
echo deberta-large batch size 32 before finetuning

python3 main.py \
--mode test \
--model microsoft/deberta-large --dataset com2sense --test_file dev --batch_size 32 --num_workers 4

# deberta-large batch size 16 after finetuning 
echo deberta-large batch size 32 after finetuning

python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/deberta_large/bs_32/ep_25_stp_1.3k_acc_68.4896_microsoft_deberta_large.pth \
--model microsoft/deberta-large --dataset com2sense --test_file dev --batch_size 32 --num_workers 4 

############################
#    BERT-BASE             #
############################

# bert-base batch size 32 before finetuning
echo bert-base batch size 32 before finetuning

python3 main.py \
--mode test \
--model google-bert/bert-base-uncased --dataset com2sense --test_file dev --batch_size 32 --num_workers 4

# bert-base batch size 16 after finetuning 
echo bert-base batch size 32 after finetuning

python3 main.py \
--mode test \
--ckpt ./results_log/com2sense/bert_base/bs_32/ep_82_stp_4.1k_acc_54.4271_google_bert_bert_base_uncased.pth \
--model google-bert/bert-base-uncased --dataset com2sense --test_file dev --batch_size 32 --num_workers 4 