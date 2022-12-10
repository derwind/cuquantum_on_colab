FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV CUQUANTUM_ROOT /opt/nvidia/cuquantum
ENV LD_LIBRARY_PATH $CUQUANTUM_ROOT/lib:$LD_LIBRARY_PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    wget https://developer.download.nvidia.com/compute/cuquantum/22.07.1/local_installers/cuquantum-local-repo-ubuntu2004-22.07.1_1.0-1_amd64.deb && \
    dpkg -i cuquantum-local-repo-ubuntu2004-22.07.1_1.0-1_amd64.deb && \
    cp /var/cuquantum-local-repo-ubuntu2004-22.07.1/cuquantum-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuquantum cuquantum-dev cuquantum-doc && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install -y python3.9-dev python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python&& \
    apt install -y cmake && pip install pybind11 pluginbase patch-ng node-semver bottle PyJWT fasteners distro colorama conan && \
    apt-get install -y libopenblas-dev && \
    pip install "qiskit[all]" && \
    pip uninstall -y qiskit-aer && \
    git clone -b 0.11.1 https://github.com/Qiskit/qiskit-aer/ && \
    cd qiskit-aer && \
    python setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DCUSTATEVEC_ROOT=$CUQUANTUM_ROOT -DCUSTATEVEC_STATIC=True && \
    pip install dist/qiskit_aer-0.11.1-cp**-cp**-linux_x86_64.whl && \
    cd .. && \
    rm -rf qiskit_aer

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
