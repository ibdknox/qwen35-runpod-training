FROM runpod/pytorch:1.1.0-cu1281-torch280-ubuntu2204

LABEL org.opencontainers.image.source="https://github.com/ibdknox/qwen35-runpod-training"
LABEL org.opencontainers.image.description="Pinned Qwen3.5 training environment for RunPod"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libz3-dev \
    && rm -rf /var/lib/apt/lists/*

# Match the package stack in Unsloth's official Qwen3.5 notebook. This image
# deliberately contains no model weights, datasets, source code, or secrets.
RUN python -m pip install --no-cache-dir uv==0.11.18 \
    && uv pip install --system --no-cache "unsloth==2026.5.9" \
    && uv pip install --system --no-cache --upgrade --no-deps \
        "tokenizers==0.22.2" \
        "trl==0.22.2" \
        "unsloth==2026.5.9" \
        "unsloth_zoo==2026.5.5" \
    && uv pip install --system --no-cache "transformers==5.2.0" \
    && uv pip install --system --no-cache --no-build-isolation \
        "flash-linear-attention==0.5.2" \
        "causal_conv1d==1.6.0" \
    && uv pip install --system --no-cache --no-deps \
        "apache-tvm-ffi==0.1.9" \
        "tilelang==0.1.8" \
    && uv pip install --system --no-cache \
        "cloudpickle==3.1.2" \
        "ml-dtypes==0.6.0" \
        "torch-c-dlpack-ext==0.1.5" \
        "z3-solver==4.15.4.0" \
    && uv pip uninstall --system torchao

ENV HF_HOME=/workspace/training/cache/huggingface \
    HF_HUB_CACHE=/workspace/training/cache/huggingface/hub \
    UV_CACHE_DIR=/workspace/training/cache/uv \
    TOKENIZERS_PARALLELISM=false

WORKDIR /workspace/training
