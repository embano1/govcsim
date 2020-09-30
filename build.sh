#! /bin/bash

REPO=embano1
NAME=vcsim
TAG=0.23.0

docker build -t ${REPO}/${NAME}:${TAG} --build-arg RELEASE=${TAG} .
