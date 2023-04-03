#! /bin/sh

NAME=python39
TAG=cu118

docker build -t ${NAME}:${TAG} .
