#! /bin/sh

NAME=python311:ubuntu22-cuda118

docker build -t ${NAME} .
