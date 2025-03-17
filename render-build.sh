#!/bin/bash
set -o errexit

# Install system dependencies
apt-get update
apt-get install -y \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libjpeg-dev \
    build-essential \
    python3-dev \
    wget \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libglib2.0-0

# Create swap space
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Install Python dependencies
pip install --no-cache-dir -r requirements.txt

# Download model file from Hugging Face
echo "Downloading model file..."
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O model.pt https://huggingface.co/UmeshSamartapu/deepfake-detection/resolve/main/model.pt

# Verify model file
if [ ! -f "model.pt" ] || [ ! -s "model.pt" ]; then
    echo "Error: Failed to download model file or file is empty"
    exit 1
fi

echo "Model file downloaded successfully"