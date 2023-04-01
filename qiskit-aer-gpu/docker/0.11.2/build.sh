#! /bin/sh

NAME=qiskit-aer-gpu
TAG=0.11.2

docker build -t ${NAME}:${TAG} .
