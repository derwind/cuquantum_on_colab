#!/bin/sh

NAME=qiskit-aer-gpu
TAG=0.11.2s-cu118

docker build -t ${NAME}:${TAG} .
