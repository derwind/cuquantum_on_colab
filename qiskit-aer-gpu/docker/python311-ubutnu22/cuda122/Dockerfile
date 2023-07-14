FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y git wget
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev && \
    wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz && \
    tar -xzvf Python-3.11.4.tgz && \
    cd Python-3.11.4 && ./configure --enable-optimizations && \
    make -j 8 && make altinstall && \
    ln -s /usr/local/bin/python3.11 /usr/bin/python && \
    rm -f /usr/bin/python3 && ln -s /usr/local/bin/python3.11 /usr/bin/python3 && \
    rm -f /usr/bin/pip && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && \
    ln -s /usr/local/bin/pip /usr/bin/pip

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
