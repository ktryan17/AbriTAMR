FROM ubuntu:latest

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    && apt-get clean

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

# Create the conda environment
RUN conda create -n abritamr -c bioconda abritamr -y

# Activate the environment by default
SHELL ["conda", "run", "-n", "abritamr", "/bin/bash", "-c"]

#first use: source activate base (this initializes the conda interactive shell)
#then use: conda activate abritamr
