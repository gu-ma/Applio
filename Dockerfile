# Base image used as starter
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Install necessary dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    python3-pip \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    wget \
    curl \
    iproute2 \
    iputils-ping \
    python3.10-venv \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update pip
RUN pip install -U --no-cache-dir pip setuptools wheel

# Change working directory
WORKDIR /src

# Copy content to image
COPY . .

# Install dependencies
RUN pip install --no-cache-dir python-ffmpeg && \
    pip install --no-cache-dir torch==2.3.1 torchvision==0.18.1 torchaudio==2.3.1 --index-url https://download.pytorch.org/whl/cu121 && \
    pip install --no-cache-dir -r requirements.txt

# Symlink python
RUN ln -n /usr/bin/python3 /usr/bin/python