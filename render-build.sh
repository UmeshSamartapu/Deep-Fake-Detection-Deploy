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
    python3-dev

# Create swap space
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Install Python dependencies
pip install -r requirements.txt