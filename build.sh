#! /bin/bash

REPO=mycloudrevolution
NAME=vcsim
TAG=0.1.0

docker build -t ${REPO}/${NAME}:${TAG} --build-arg RELEASE=${TAG} .
