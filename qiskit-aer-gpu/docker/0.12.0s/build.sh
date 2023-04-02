#! /bin/sh

NAME=qiskit-aer-gpu
TAG=0.12.0s

docker build -t ${NAME}:${TAG} .
