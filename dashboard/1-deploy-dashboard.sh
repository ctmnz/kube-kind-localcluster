#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
kubectl apply -f dashboard-roles-user.yaml 

kubectl -n kubernetes-dashboard create token admin-user


echo "Now you can go to: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/ "
echo "user: admin-user"
echo "token: copy/paste from above"

kubectl proxy
