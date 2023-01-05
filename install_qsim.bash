#! /bin/bash

setup_dependencies()
{
    sudo apt install -y build-essential && cmake && pip install pybind11
}

setup_cuda112()
{
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda-repo-ubuntu1804-11-2-local_11.2.0-460.27.04-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-11-2-local_11.2.0-460.27.04-1_amd64.deb
    sudo apt-key add /var/cuda-repo-ubuntu1804-11-2-local/7fa2af80.pub
    sudo apt-get update
    sudo apt-get -y install cuda
}

setup_cuda()
{
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda-repo-ubuntu1804-11-2-local_11.2.0-460.27.04-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-11-2-local_11.2.0-460.27.04-1_amd64.deb
    sudo apt-key add /var/cuda-repo-ubuntu1804-11-2-local/7fa2af80.pub
    sudo apt-get update
    sudo apt-get -y install cuda
}

setup_qsim()
{
    git clone https://github.com/quantumlib/qsim.git
    cd qsim
    make clean all
    pip install .
}

export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH} }
export CUQUANTUM_DIR=/opt/nvidia/cuquantum
export LD_LIBRARY_PATH=$CUQUANTUM_DIR/lib:$LD_LIBRARY_PATH

setup_dependencies
setup_cuda112
setup_cuQuantum
setup_qsim

echo "finish all setup"
