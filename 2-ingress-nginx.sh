#!/bin/bash
kubectl create namespace local-apps-namespace
kubectl apply -f ingress-nginx.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

