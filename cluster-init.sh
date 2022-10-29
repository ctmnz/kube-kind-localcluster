#!/bin/bash
set -e

# Create the local kubernetes cluster (using kind)
kind create cluster --name=gitops-cluster --config=gitops-cluster.yaml

# Create a namespace for the 'argocd' installation
kubectl create namespace argocd


# Install nginx ingress controller
kubectl apply -f ingress-nginx.yaml

### Wait ingress nginx pod creation
echo -n "Wait for pod app.kubernetes.io/component=controller to be created."
while : ; do
  [ ! -z "`kubectl -n ingress-nginx get pod --selector=app.kubernetes.io/component=controller 2> /dev/null`" ] && echo && break
  sleep 2
  echo -n "."
done
### Wait pod is ready
timeout="600s"
echo -n "Wait for pod app.kubernetes.io/component=controller to be ready (timeout=$timeout)..."
kubectl wait  --namespace ingress-nginx \
              --for=condition=ready pod \
              --selector=app.kubernetes.io/component=controller \
              --timeout=$timeout

# Once the installatino of the nginx ingress controller is ready we can install ArgoCD platform
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -n argocd -f argocd-manifest.yaml
kubectl apply -f argocd-ingress.yaml

## wait util the build is ready
kubectl wait --namespace argocd \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=argocd-server \
  --timeout=180s


# Print the address, the user, and the password for the inital ArgoCD login
p=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
echo "### ArgoCD WebUI: https://argocd.127.0.0.1.nip.io | USER: admin | PASSWORD: $p"

## argocd cli authentication
#argocd login argocd.127.0.0.1.nip.io --name admin --password $p


# Wait unitl the argocd web is returning 200 OK
echo "Waiting for argocd .."
until $(curl --output /dev/null --silent --insecure --head --fail https://argocd.127.0.0.1.nip.io); do
    printf '.'
    sleep 1
done

argocd login  argocd.127.0.0.1.nip.io --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo) --insecure --grpc-web
## authenticate argocd in the private repo
# argocd repo add https://github.com/argoproj/argocd-example-apps --username <username> --password <password>


## Deploy apps

## simpleapp01
# argocd app create simpleapp01 --repo https://github.com/ctmnz/argocd-example-apps.git --path daniel-example-app --dest-server https://kubernetes.default.svc --dest-namespace default --grpc-web
# argocd app sync simpleapp01 --grpc-web
# argocd app set simpleapp01 --sync-policy automated --grpc-web




