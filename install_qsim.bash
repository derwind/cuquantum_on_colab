#! /bin/bash

setup_dependencies()
{
    sudo apt install -y build-essential && cmake && pip install pybind11
}

setup_cuda112()
{
    wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda_11.2.0_460.27.04_linux.run
    sudo sh cuda_11.2.0_460.27.04_linux.run --toolkit --silent --override
}

setup_cuQuantum()
{
    wget https://developer.download.nvidia.com/compute/cuquantum/22.11.0/local_installers/cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb
    sudo dpkg -i cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb
    sudo cp /var/cuquantum-local-repo-ubuntu1804-22.11.0/cuquantum-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuquantum cuquantum-dev cuquantum-doc
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
