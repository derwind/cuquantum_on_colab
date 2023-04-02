FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV CUQUANTUM_ROOT /opt/nvidia/cuquantum
ENV CUTENSOR_ROOT /opt/nvidia/cutensor
ENV LD_LIBRARY_PATH $CUQUANTUM_ROOT/lib:$CUTENSOR_ROOT/lib/11:$LD_LIBRARY_PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    wget https://developer.download.nvidia.com/compute/cuquantum/22.11.0/local_installers/cuquantum-local-repo-ubuntu2004-22.11.0_1.0-1_amd64.deb && \
    dpkg -i cuquantum-local-repo-ubuntu2004-22.11.0_1.0-1_amd64.deb && \
    cp /var/cuquantum-local-repo-ubuntu2004-22.11.0/cuquantum-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuquantum cuquantum-dev cuquantum-doc && \
    cd /opt/nvidia && wget https://developer.download.nvidia.com/compute/cutensor/redist/libcutensor/linux-x86_64/libcutensor-linux-x86_64-1.6.2.3-archive.tar.xz && \
    tar xf libcutensor-linux-x86_64-1.6.2.3-archive.tar.xz && ln -s libcutensor-linux-x86_64-1.6.2.3-archive cutensor && rm libcutensor-linux-x86_64-1.6.2.3-archive.tar.xz && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install -y python3.9-dev python3-pip && \
    ln -s /usr/bin/python3.9 /usr/bin/python && \
    rm -f /usr/bin/python3 && ln -s /usr/bin/python3.9 /usr/bin/python3 && \
    apt install -y cmake && pip install pybind11 pluginbase patch-ng node-semver==0.6.1 bottle PyJWT fasteners distro colorama conan==1.59.0 scikit-build && \
    apt-get install -y libopenblas-dev && \
    pip install "qiskit[all]" && \
    pip uninstall -y qiskit-aer && \
    cd / && git clone https://github.com/Qiskit/qiskit-aer.git && \
    cd qiskit-aer && git checkout 4e10831f89fb49b2652a18056be64cb1db22d190 && \
    python ./setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DAER_CUDA_ARCH="7.5" -DCUQUANTUM_ROOT=$CUQUANTUM_ROOT -DCUTENSOR_ROOT=$CUTENSOR_ROOT -DAER_ENABLE_CUQUANTUM=true  -- && \
    pip install dist/qiskit_aer-0.13.0-cp**-cp**-linux_x86_64.whl && \
    cd .. && \
    rm -rf qiskit_aer

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
