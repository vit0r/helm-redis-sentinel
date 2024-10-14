#!/bin/bash

REPO=vit0r
IMAGE=node-sentinel
TAG="latest"

docker build -t $REPO/$IMAGE-nodejs:${TAG} --target nodejs .
docker push $REPO/$IMAGE-nodejs:${TAG}
docker build -t $REPO/$IMAGE-java-consoleapp:${TAG} --target demo .
docker push $REPO/$IMAGE-java-consoleapp:${TAG}
# toobox for tests servers connections and URI's
docker build -t $REPO/toolbox:${TAG} --target toolbox .
docker push $REPO/toolbox:${TAG}

kubectl apply -f secrets.yaml -f configmaps.yaml -f deploy.yaml
kubectl apply -f toolbox.yaml