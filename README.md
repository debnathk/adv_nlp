

# Commonsense inference using Large-Language Models


This repo contains the dataset and baseline model weights for 
[Com2Sense](https://arxiv.org/abs/2106.00969) Benchmark.

---

  
 
## Table of Contents

  

-  [Dataset](#Dataset)

-  [Models](#Models)

-  [Training](#Training)

-  [Inference](#Inference)
  
---

  

## Dataset

The directory is structured as follows:
 
```
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

```

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

## Training

For training we provide a sample script, with custom arguments ([train.sh](./train.sh))
  

```bash
$ python3 main.py \
--mode train \
--dataset com2sense \
--model roberta-large \
--expt_dir ./results \
--expt_name roberta \
--run_name demo \
--seq_len 128 \
--epochs 100 \
--batch_size 16 \
--acc_step 4 \
--lr 1e-5 \
--log_interval 500 \
--gpu_ids 0,1,2,3 \
--use_amp T \
-data_parallel
```

The log directory for this sample script would be `./results/roberta/demo/`

The Train & Validation metrics are logged to TensorBoard.
 
```bash
$ tensorboard --logdir ...
```

Note: `logdir = expt_dir/expt_name/run_name/`


---

 
## Inference
   
**TO-DO**

For inference on **dev set**, we can modify as follows ([test.sh](./test.sh)):
  

```bash
$ python3 main.py \
--mode test \
--model roberta-large \
--dataset com2sense \
--ckpt ./path_to_model.pth
--test_file test \
--pred_file roberta_large_results.csv 
```
---
   

## Leaderboard

To test your own model, modify the line 128:
```
model = Transformer(args.model, args.num_cls, text2text, num_layers=args.num_layers)
```

To evaluate on the **official test set**, we have two modes:

- **Evaluation**

Run with `eval` mode
    
```bash
$ python3 leaderboard.py \
--mode eval \
--ckpt /expt_dir/expt_name/run_name/model.pth
```

Output:

```
{
    'pairwise': 0.25,
    'standard': 0.50
}
```

- **Submit**

Fill in the information in `submit.yaml`, and then run with `submit` mode
    
```bash
$ python3 leaderboard.py \
--mode submit \
--ckpt /expt_dir/expt_name/run_name/model.pth \
--user_info ./submit.yaml
```

You can view the leaderboard at `URL`

---
