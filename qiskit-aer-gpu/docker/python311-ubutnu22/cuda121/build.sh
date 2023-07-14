#! /bin/sh

NAME=python311:ubuntu22-cuda121

docker build -t ${NAME} .
