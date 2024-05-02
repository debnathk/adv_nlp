
# Commonsense inference using Large-Language Models

This repo contains the dataset and baseline model weights for
[Com2Sense](https://arxiv.org/abs/2106.00969) Benchmark.

---

## Table of Contents

- [Dataset](#dataset)
- [Models](#models)
- [Installation](#installation)
- [Training](#training)
- [Inference](#inference)
  
---

## Dataset

The directory is structured as follows:

```bash
data
├── train.json
├── dev.json
└── test.json

data
├── pair_id_train.json
├── pair_id_dev.son
└── pair_id_test.json
```

Each data file has the following format:

```json

[   
    {
        "id": "",
        "sent": "",
        "label": "",
        "domain": "",
        "scenario": "",
        "numeracy": ""
    },
    ...
  ]

```

For test.json, the ground-truth labels are excluded.

Pair id files are used to get data pair information and could be used to calculate pairwise accuracy.

---

## Models

| Model             | Std / Pair Accuracy | Weights  |
| ---------         | ------------------- | --------- |
| UnifiedQA-T5-3B      | 76.21 / 57.54       | [Link](https://drive.google.com/file/d/1uQnxZAkSoDc8JEmESzTl0XVE8kHpm_10/view?usp=sharing)|
| BERT-base     | 54.35 / 24.81       | ... |
| RoBERTa-large     | 62.15 / 37.85       | ... |
| DeBERTa-large     | 68.67 / 28.59       | ... |
| T5-large     | 61.59 / 36.72       | ... |
| XLNet-base     | 54.43 / 27.60       | ... |
| ERNIE-2.0-base     | 55.86 / 30.73       | ... |

---

## Installation

1. Clone this repository.
2. Create a Python 3.11.7 or newer conda environment.

```bash
conda create -n my_conda_env python=3.11.7
conda activate my_conda_env
```

3. Install the required python modules.

```
pip install -r requirements.txt
```

---

## Training

For training we provide a sample script, with custom arguments:
  
```bash
$ python3 main.py --mode train \
--expt_dir ./results_log/com2sense \
--expt_name roberta_large \
--model roberta-large \
--dataset com2sense \
--run bs_32 \
--batch_size 32 \
--seq_len 128
```

The log directory for this sample script would be `./results_log/com2sense/roberta_large/bs_32`
Model names should match as seen on [HuggingFace](https://huggingface.co/)

The Train & Validation metrics are logged to TensorBoard.

```bash
tensorboard --logdir ...
```

Note: `logdir = expt_dir/expt_name/run_name/`

---

## Inference

For inference on **dev set**, we can modify as follows:
  
```bash
$ python3 main.py \
--mode test \
--ckpt ./path/to/model.pth \
--model roberta-large \
--dataset com2sense \
--batch_size 32
```

---

Note: `If running this on VCU's athena, refer to ./slurm_scripts. Modify your environment name and run it using sbatch`
