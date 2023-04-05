FROM nvidia/cuda:11.6.2-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV CUQUANTUM_ROOT /opt/nvidia/cuquantum
ENV LD_LIBRARY_PATH $CUQUANTUM_ROOT/lib:$LD_LIBRARY_PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    wget https://developer.download.nvidia.com/compute/cuquantum/22.11.0/local_installers/cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb && \
    dpkg -i cuquantum-local-repo-ubuntu1804-22.11.0_1.0-1_amd64.deb && \
    cp /var/cuquantum-local-repo-ubuntu1804-22.11.0/cuquantum-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get install -y cuquantum cuquantum-dev cuquantum-doc && \
    apt install -y build-essential gcc-8 g++-8 zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev && \
    rm /usr/bin/gcc && rm /usr/bin/g++ && \
    ln -s /usr/bin/gcc-8 /usr/bin/gcc && ln -s /usr/bin/g++-8 /usr/bin/g++ && \
    wget https://www.python.org/ftp/python/3.10.10/Python-3.10.10.tgz && \
    tar -xzvf Python-3.10.10.tgz && \
    cd Python-3.10.10 && ./configure --enable-optimizations && \
    make -j 8 && make altinstall && \
    ln -s /usr/local/bin/python3.10 /usr/bin/python && \
    rm -f /usr/bin/python3 && ln -s /usr/local/bin/python3.10 /usr/bin/python3 && \
    rm -f /usr/bin/pip && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && \
    ln -s /usr/local/bin/pip /usr/bin/pip && \
    apt install -y cmake && pip install pybind11 pluginbase patch-ng node-semver==0.6.1 bottle PyJWT fasteners distro colorama conan==1.59.0 && \
    apt-get install -y libopenblas-dev && \
    pip install "qiskit[all]==0.41.1" && \
    pip uninstall -y qiskit-aer && \
    git clone -b 0.11.2 https://github.com/Qiskit/qiskit-aer/ && \
    cd qiskit-aer && \
    python setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DAER_CUDA_ARCH="7.0" -DCUSTATEVEC_ROOT=$CUQUANTUM_ROOT && \
    pip install dist/qiskit_aer-0.11.2-cp**-cp**-linux_x86_64.whl

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
