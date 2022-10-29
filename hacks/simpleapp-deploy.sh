#!/bin/sh

## simpleapp01 from a public github repo
argocd app create simpleapp01 --repo https://github.com/ctmnz/poc-applications.git --path simpleapp  --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy auto --self-heal --sync-retry-backoff-max-duration 30s  --grpc-web
