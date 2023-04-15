#!/bin/sh

NAME=qiskit-aer-gpu
TAG=0.11.2s-cu116

docker build -t ${NAME}:${TAG} .
