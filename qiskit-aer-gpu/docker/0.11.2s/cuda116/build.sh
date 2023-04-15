#!/bin/sh

NAME=qiskit-aer-gpu
TAG=0.11.2s

docker build -t ${NAME}:${TAG} .
