# Qwen3.5 RunPod training image

Public, reproducible `linux/amd64` training environment for Qwen3.5 on RunPod.

It contains only a public RunPod PyTorch 2.8/CUDA 12.8 base and pinned public
training packages from Unsloth's official Qwen3.5 recipe. It deliberately does
not contain model weights, datasets, adapters, source code, or credentials.

```text
ghcr.io/ibdknox/qwen35-runpod-training:pt2.8-tf5.2
```

Model weights should be downloaded from Hugging Face when a pod starts.

RunPod cold pulls from GHCR have been observed to stall on this 11.5 GiB
image. For short experiments, prefer RunPod's base image plus the equivalent
small dependency bootstrap in the DecisionWorld training scaffold.
