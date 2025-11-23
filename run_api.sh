#!/bin/bash

# Hunyuan3D-2 API Server Launch Script
# This script launches the FastAPI server with configurable parameters

# ============================================
# GPU Configuration
# ============================================
# Set which GPUs are visible (comma-separated list)
export CUDA_VISIBLE_DEVICES=0

# ============================================
# Model Directory Configuration
# ============================================
# Set the local models directory
# The model loader will look for models in: ${HY3DGEN_MODELS}/<model_name>/<subfolder>
export HY3DGEN_MODELS="./models"

# ============================================
# Server Configuration
# ============================================
HOST="0.0.0.0"
PORT=7100

# ============================================
# Model Configuration
# ============================================
# Available model options:
# - Hunyuan3D-2mini (lightweight, 0.6B, 6GB VRAM)
# - Hunyuan3D-2mv (multiview, 1.1B)
# - Hunyuan3D-2 (standard, 1.1B)
# - Hunyuan3D-2.1 (latest, 3.0B)
# Or use HuggingFace repo IDs like: tencent/Hunyuan3D-2mini

MODEL_PATH="Hunyuan3D-2"
SUBFOLDER="hunyuan3d-dit-v2-0-turbo"  # Use turbo version for faster inference

# Texture generation model (only used if --enable_tex is set)
TEX_MODEL_PATH="Hunyuan3D-2"

# ============================================
# Device Configuration
# ============================================
DEVICE="cuda"

# ============================================
# Runtime Configuration
# ============================================
# Maximum number of concurrent model requests
LIMIT_CONCURRENCY=1

# Enable texture generation (requires more VRAM: 16GB total)
ENABLE_TEX="--enable_tex"  # Set to "--enable_tex" to enable texture generation

# ============================================
# Launch API Server
# ============================================
echo "=========================================="
echo "Launching Hunyuan3D-2 API Server"
echo "=========================================="
echo "Host: $HOST"
echo "Port: $PORT"
echo "GPUs: $CUDA_VISIBLE_DEVICES"
echo "Models Directory: $HY3DGEN_MODELS"
echo "Model: $MODEL_PATH"
echo "Subfolder: $SUBFOLDER"
echo "Texture Model: $TEX_MODEL_PATH"
echo "Device: $DEVICE"
echo "Concurrency Limit: $LIMIT_CONCURRENCY"
echo "Texture Generation: ${ENABLE_TEX:-disabled}"
echo "=========================================="

python3 api_server.py \
    --host "$HOST" \
    --port "$PORT" \
    --model_path "$MODEL_PATH" \
    --subfolder "$SUBFOLDER" \
    --tex_model_path "$TEX_MODEL_PATH" \
    --device "$DEVICE" \
    --limit-model-concurrency "$LIMIT_CONCURRENCY" \
    $ENABLE_TEX
