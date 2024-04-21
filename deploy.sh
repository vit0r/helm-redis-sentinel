#!/bin/bash

REPO=vit0r
IMAGE=node-sentinel
TAG="latest"
docker build -t $REPO/$IMAGE:${TAG} .
docker push $REPO/$IMAGE:${TAG}

kubectl apply -f secrets.yaml -f configmaps.yaml -f deploy.yaml
