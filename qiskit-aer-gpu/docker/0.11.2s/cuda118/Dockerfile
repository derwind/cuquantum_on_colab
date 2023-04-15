FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV CUQUANTUM_ROOT /usr/lib/x86_64-linux-gnu/libcuquantum/11
ENV LD_LIBRARY_PATH $CUQUANTUM_ROOT:$LD_LIBRARY_PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    wget https://developer.download.nvidia.com/compute/cuquantum/23.03.0/local_installers/cuquantum-local-repo-ubuntu2004-23.03.0_1.0-1_amd64.deb && \
    dpkg -i cuquantum-local-repo-ubuntu2004-23.03.0_1.0-1_amd64.deb && \
    cp /var/cuquantum-local-repo-ubuntu2004-23.03.0/cuquantum-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuquantum cuquantum-cuda-11 && \
    rm -f /etc/alternatives/cuda && ln -s /usr/local/cuda-11.8 /etc/alternatives/cuda
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev && \
    wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz && \
    tar -xzvf Python-3.9.16.tgz && \
    cd Python-3.9.16 && ./configure --enable-optimizations && \
    make -j 8 && make altinstall && \
    ln -s /usr/local/bin/python3.9 /usr/bin/python && \
    rm -f /usr/bin/python3 && ln -s /usr/local/bin/python3.9 /usr/bin/python3 && \
    rm -f /usr/bin/pip && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && \
    ln -s /usr/local/bin/pip /usr/bin/pip
RUN apt install -y cmake && pip install pybind11 pluginbase patch-ng node-semver==0.6.1 bottle PyJWT fasteners distro colorama conan==1.59.0 && \
    apt-get install -y libopenblas-dev && \
    pip install "qiskit[all]==0.41.1" && \
    pip uninstall -y qiskit-aer && \
    cd / && git clone -b 0.11.2 https://github.com/Qiskit/qiskit-aer/ && \
    cd qiskit-aer && \
    python setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DAER_CUDA_ARCH="7.0; 7.5; 8.0" -DCUSTATEVEC_ROOT=$CUQUANTUM_ROOT -DCUSTATEVEC_STATIC=true

CMD ["bash"]
