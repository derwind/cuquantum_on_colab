FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV CUQUANTUM_ROOT /opt/nvidia/cuquantum
ENV LD_LIBRARY_PATH $CUQUANTUM_ROOT/lib:$LD_LIBRARY_PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    cd /opt/nvidia && \
    wget https://developer.download.nvidia.com/compute/cuquantum/redist/cuquantum/linux-x86_64/cuquantum-linux-x86_64-22.11.0.13-archive.tar.xz && \
    tar Jxfv cuquantum-linux-x86_64-22.11.0.13-archive.tar.xz && ln -s cuquantum-linux-x86_64-22.11.0.13-archive cuquantum && rm cuquantum-linux-x86_64-22.11.0.13-archive.tar.xz && \
    cd /
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev && \
    wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz && \
    tar -xzvf Python-3.10.11.tgz && \
    cd Python-3.10.11 && ./configure --enable-optimizations && \
    make -j 8 && make altinstall && \
    ln -s /usr/local/bin/python3.10 /usr/bin/python && \
    rm -f /usr/bin/python3 && ln -s /usr/local/bin/python3.10 /usr/bin/python3 && \
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
