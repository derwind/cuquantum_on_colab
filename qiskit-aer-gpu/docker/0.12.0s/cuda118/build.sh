#! /bin/sh

NAME=qiskit-aer-gpu
TAG=0.12.0s-cu118

docker build -t ${NAME}:${TAG} .
