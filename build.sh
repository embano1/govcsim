#! /bin/bash

REPO=embano1
NAME=vcsim
TAG=0.22.1

docker build -t ${REPO}/${NAME}:${TAG} --build-arg RELEASE=${TAG} .
