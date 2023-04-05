#! /bin/sh

NAME=python310
TAG=cu116

docker build -t ${NAME}:${TAG} .
