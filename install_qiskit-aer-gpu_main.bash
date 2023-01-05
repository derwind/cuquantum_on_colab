#! /bin/bash

# https://zenn.dev/converghub/articles/73007f5e24f5fe

setup_dependencies()
{
    sudo apt install -y cmake && pip install pybind11 pluginbase patch-ng node-semver bottle PyJWT fasteners distro colorama conan
}

setup_cuda()
{
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-ubuntu1804-12-0-local_12.0.0-525.60.13-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-12-0-local_12.0.0-525.60.13-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu1804-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuda
}

setup_cuQuantum()
{
    wget https://developer.download.nvidia.com/compute/cuquantum/22.11.0/local_installers/cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb
    sudo dpkg -i cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb
    sudo cp /var/cuquantum-local-repo-ubuntu1804-22.11.0/cuquantum-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuquantum cuquantum-dev cuquantum-doc
}

setup_OpenBLAS()
{
    sudo apt-get update
    sudo apt-get install -y libopenblas-dev
}

setup_QiskitExceptAer()
{
    pip3 install "qiskit[all]"
    pip3 uninstall -y qiskit-aer
}

setup_QiskitAerGPU()
{
    git clone https://github.com/Qiskit/qiskit-aer/
    cd qiskit-aer
    git checkout b42208d
    python setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DCUSTATEVEC_ROOT=$CUQUANTUM_DIR -DCUSTATEVEC_STATIC=True
    pip install dist/qiskit_aer-0.12.0-cp**-cp**-linux_x86_64.whl
}

export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH} }
export CUQUANTUM_DIR=/opt/nvidia/cuquantum
export LD_LIBRARY_PATH=$CUQUANTUM_DIR/lib:$LD_LIBRARY_PATH

setup_dependencies
setup_cuda
setup_cuQuantum
setup_OpenBLAS
setup_QiskitExceptAer
setup_QiskitAerGPU

echo "finish all setup"
