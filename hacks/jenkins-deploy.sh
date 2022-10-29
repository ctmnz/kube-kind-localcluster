argocd app create jenkinsapp --repo https://github.com/ctmnz/poc-applications.git --path jenkins --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy auto --self-heal --sync-retry-backoff-max-duration 30s  --grpc-web

## get the initial admin password
# kubectl exec -n jenkins-demo --stdin --tty jenkins-deployment-XXXXXXXX-XXXX  -- /bin/bash
