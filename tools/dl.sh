#!/bin/bash
# Deep learning: make sure conda is installed or using the pytorch docker image.

function addpath() {
    if [ -d "$1" ]; then
        echo "export PATH=$1:\$PATH" >> ~/.zshrc
        echo "Added $1 to PATH."
    fi
}

if [ -d "/usr/local/cuda/bin" ] && ! command -v nvcc >/dev/null; then
    addpath /usr/local/cuda/bin
fi

if [ -d "/opt/conda/bin" ] && ! command -v conda >/dev/null; then
    addpath /opt/conda/bin
fi

conda install -n base conda-libmamba-solver
conda config --set solver libmamba
conda config --add channels pytorch
conda config --add channels nvidia
conda config --add channels conda-forge

apt install python3-venv pipx -y
pipx install bpytop
pipx install nvitop
