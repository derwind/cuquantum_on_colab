#! /bin/bash

setup_cuQuantum()
{
    pip install cuquantum-python cupy-cuda112
}

setup_blueqat()
{
    pip install blueqat
}

setup_cuQuantum
setup_blueqat

echo "finish all setup"
