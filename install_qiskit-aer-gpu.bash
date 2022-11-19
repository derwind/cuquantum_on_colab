#! /bin/bash

# from https://note.com/kokkkorokoro/n/nc806314d6594

setup_python38()
{
    # Step1 Colab上に既にある豊富なパッケージをpython3.8でインストールしたパッケージのアーカイブをDownload
    echo "#Step1 start Download python3.8packages(tar.gz) of Share File from GoogleDrive"
    echo "10_wfp1U4rMzc20eiGNrdQa9V2S9ByJwV" > ./FILE_ID ;
    echo "wget  -O `cat ./FILE_ID`.tar.gz \"https://drive.google.com/uc?export=download&id=`cat ./FILE_ID`&confirm=t&"|tee  ./FILE_ID_WGET_CMD  ;
    echo "`wget -q "https://drive.google.com/uc?export=download&id=\`cat ./FILE_ID\`" -O - | perl -pe 's/\r*\n//g' | perl -pe 's/^.*(uuid\=[^\"]+)\".*$/${1}/g'`"|tee -a ./FILE_ID_WGET_CMD  ;
    echo "&uc-download-link=Download&nbsp;anyway\"" |tee -a ./FILE_ID_WGET_CMD ;
    /bin/bash ./FILE_ID_WGET_CMD
    echo "#Step1 End Download python3.8packages(tar.gz) of Share File from GoogleDrive"

    # Step2 python3.8インタープリタとpython3-pipをinstallします
    echo "Step2 Start python3.8インタープリタとpython3-pipをinstallします\n"
    sudo apt-get install -y python3.8
    sudo apt-get install -yf python3-pip
    echo "Step2 End python3.8インタープリタとpython3-pipをinstallします"

    # Step3
    echo "#Step3 Start カレントディレクトリに./dist-packagesを作成しpython3.8packages(tar.gz)を解凍し、削除"
    mkdir ./dist-packages
    tar xvzf `cat ./FILE_ID`.tar.gz -C ./dist-packages
    rm `cat ./FILE_ID`.tar.gz
    echo "#Step3 End カレントディレクトリに./dist-packagesを作成しpython3.8packages(tar.gz)を解凍し、削除"

    # Step4
    echo "# Step4 Start python3.7のgoogle*パッケージを,解凍したpython3.8パッケージディレクトリにシムリンク張る"
    rm -fr /content/dist-packages/usr/local/lib/python3.8/dist-packages/google*
    ls -d /usr/local/lib/python3.7/dist-packages/google* | perl -pe 's/^(.+)$/sudo ln -sf ${1} \/content\/dist-packages\/usr\/local\/lib\/python3.8\/dist-packages\//g' |/bin/bash -
    ls -la /content/dist-packages/usr/local/lib/python3.8/dist-packages/google*
    echo "# Step4 End python3.7のgoogle*パッケージを,解凍したpython3.8パッケージディレクトリにシムリンク張る"

    # Step5
    echo "# Step5 Start そして解凍したpython3.8パッケージディレクトリを正規のpython3.8パッケージディレクトリにシムリンク張り置き換える"
    rm -fr /usr/local/lib/python3.8/dist-packages
    sudo ln -s /content/dist-packages/usr/local/lib/python3.8/dist-packages /usr/local/lib/python3.8/
    echo "# Step5 End そして解凍したpython3.8パッケージディレクトリを正規のpython3.8パッケージディレクトリにシムリンク張り置き換える"

    # Step6
    echo "# Step6 Start pythonインタプリタを3.8に変更する"
    echo "python3.8再起動ステップその4"
    sudo ln -sf `which python3.8` /etc/alternatives/python3
    python --version
    echo "# Step6 End pythonインタプリタを3.8に変更する"

    # Strep7 3.8になったpythonでipkykernel実行し"engbjapanpython3.8"と名付けてランタイムを別にインストールします
    echo "#Step7 Start engbjapanpython3.8と名付けてランタイム(Python 3.8)ipykernelを起動"
    sudo python -m ipykernel install --name "engbjapanpython3.8" --user
    echo "#Step7 End engbjapanpython3.8と名付けてランタイム(Python 3.8)ipykernelを起動"
    echo "全て、終了したら、「ランタイムのタイプ変更と、再接続」を実施してください"
}

setup_dependencies()
{
    sudo apt install -y nvidia-cuda-toolkit
    sudo apt install -y python3.8-dev
    sudo apt install -y cmake && pip3 install pybind11
}

setup_cuQuantum()
{
    wget https://developer.download.nvidia.com/compute/cuquantum/22.07.1/local_installers/cuquantum-local-repo-ubuntu1804-22.07.1_1.0-1_amd64.deb
    sudo dpkg -i cuquantum-local-repo-ubuntu1804-22.07.1_1.0-1_amd64.deb
    sudo cp /var/cuquantum-local-repo-ubuntu1804-22.07.1/cuquantum-*-keyring.gpg /usr/share/keyrings/
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
    pip3 uininstall -y qiskit-aer
}

setup_QiskitAerGPU()
{
    git clone -b 0.11.1 https://github.com/Qiskit/qiskit-aer/
    cd qiskit-aer
    python3 setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DCUSTATEVEC_ROOT=$CUQUANTUM_DIR
    pip3 install dist/qiskit_aer-0.12.0-cp**-cp**-linux_x86_64.whl
}

export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH} }
export CUQUANTUM_DIR="/opt/nvidia/cuquantum"

setup_python38
setup_dependencies
setup_cuQuantum
setup_OpenBLAS
setup_QiskitExceptAer
setup_QiskitAerGPU

echo "finish all setup"
