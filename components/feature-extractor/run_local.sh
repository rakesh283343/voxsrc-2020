#!/bin/bash
# @TODO run this in the components container the same was as defined in the component.yaml
# @param --skip-data-fetch to read local data that was already fetched from GCS
# @param --force-training-reset to re-train even if there is existing training data
#                               (required to reset dev checkpoints)
# @param --test_interval=X Set X to change num epochs between compute of val EER,
#                          but also, LR decay
# @param --run-id=X Set X to resume an interrupted run, loading
#                   artifacts saved under the previously generated run
#                   ID. This automatically happens when kubeflow runs
#                   are preempted, but must be manually passed for runs
#                   outside of kubeflow.
# @note Flags for the "small" dataset:
#         --test_list=vox1_test_list_small.txt \
#         --train_list=vox2_train_list_small.txt \
#         --test_path=voxceleb1-small-wav.tar.gz \
#         --train_path=voxceleb2-small-m4a.tar.gz
# set common source dir (build_image.sh does something similar)
export VOX_COMMON_SRC_DIR="../../common/src/"

# run the component workload
python3 src/feature_extractor.py \
  --data-bucket=voxsrc-2020-voxceleb-v4 \
  --test_list=vox1_no_cuda.txt --train_list=vox2_no_cuda.txt \
  --test_path=vox1_no_cuda.tar.gz --train_path=vox2_no_cuda.tar.gz \
  --no-cuda \
  $@