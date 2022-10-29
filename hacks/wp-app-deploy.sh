argocd app create wp01 --repo https://github.com/ctmnz/poc-applications.git --path wp-app --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy auto --self-heal --sync-retry-backoff-max-duration 30s  --grpc-web

