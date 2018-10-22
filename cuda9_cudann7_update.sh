#!/bin/bash
# @author: dghosh
# references:
# 	1. https://jhui.github.io/2017/09/07/AWS-P2-CUDA-CuDNN-TensorFlow/
#	2. https://kevinzakka.github.io/2017/08/13/aws-pytorch/#toc4
#	3. https://github.com/kevinzakka/blog-code/blob/master/aws-pytorch/install.sh
#	4. http://pytorch.org/
#	5. https://github.com/facebookresearch/fairseq-py/issues/6
#	6. https://yangcha.github.io/Install-CUDA8/

# check GPU
lspci | grep -i nvidia

# install cuda packages
sudo apt-get --assume-yes dist-upgrade --allow-unauthenticated
sudo apt-get update
sudo apt-get --assume-yes upgrade

cd /data/work/pkgs
mkdir cuda9 && cd cuda9
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.1.2.21-1+cuda9.0_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.1.2.21-1+cuda9.0_amd64.deb
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo dpkg -i libcudnn7_7.1.2.21-1+cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.1.2.21-1+cuda9.0_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo apt-get update
sudo apt-get install cuda-9-0 # cuda package now points to cuda-9-0

# update bashrc with CUDA, CPATH references
cat >> ~/.bashrc << 'EOF'
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64\
${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CPATH=/usr/local/cuda-9.0/include\
${CPATH:+:${CPATH}}
EOF
source ~/.bashrc

# setup CUDANN headers
# download package from Nvidia dev center manually
cd /data/work/pkgs/cuda9

# cudaNN should extract to cuda dir
sudo cp -P ./cuda/include/cudnn.h /usr/local/cuda-9.0/include/
sudo cp -P ./cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/
sudo chmod a+r /usr/local/cuda-9.0/lib64/libcudnn*
nvcc --version
nvidia-smi

# Configure the GPU setting to be persistent
sudo nvidia-smi -pm 1

# Disable autoboost
sudo nvidia-smi --auto-boost-default=0
nvidia-smi

# if latest tensorflow update to 1.7 gives you trouble
# check https://github.com/tensorflow/models/issues/3835
# pip install tf-nightly-gpu

# setup anaconda 3-4.4.0
cd ~/pkgs/
wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
bash Anaconda3-4.4.0-Linux-x86_64.sh -b
cat >> ~/.bashrc << 'EOF'
export PATH=$HOME/anaconda3/bin:${PATH}
EOF
source ~/.bashrc

# install pytorch
conda upgrade -y --all
conda install pytorch torchvision -c pytorch
pip install http://download.pytorch.org/whl/cu80/torch-0.3.1-cp36-cp36m-linux_x86_64.whl
pip install virtualenv numpy scipy matplotlib torchvision tensorboard_logger tqdm easydict opencv-python tensorboardX

# setup venv
conda create --name deeplearn
source activate deeplearn
conda info --envs

# reboot box
sudo reboot
