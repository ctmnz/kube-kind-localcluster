## Local Kubernetes Cluster for GitOps (ArgoCD) experiments

# Prerequisites
- Docker Desktop / Docker [How to install docker](https://docs.docker.com/desktop/)
- kind  [How to install kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- kubectl [How to install kubectl](https://kubernetes.io/docs/tasks/tools/)
- Git  [How to install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- ArgoCD cli [ArgoCD-cli installtion](https://argo-cd.readthedocs.io/en/stable/cli_installation/)
- GitHub/Bitbucket repository [GitHub instructions](https://docs.github.com/en/get-started/quickstart/hello-world) or just fork [this public repo](https://github.com/ctmnz/poc-applications) 

# Build
1. Create kubernetes cluster using kind `(automated in the cluster-init.sh)`
2. Install nginx ingress controller `(automated in the cluster-init.sh)`
3. Install ArgoCD controller `(automated in the cluster-init.sh)`
4. Install Example Apps

Go to hacks directory and run the examples :
```
cd hacks

## Installing simple nginx
./just-nginx-deploy.sh

## Install a simple flask/reactive app
./simpleapp-deploy.sh

## Install a another reacive app (randomly picked from internet)
./simpleapp-deploy.sh

## Install fully functional Wordpress portal
./wp-app-deploy.sh

```
5. Install your own app
```
- Create your own public repo or just fork https://github.com/ctmnz/poc-applications
- Create a directory for your build (i.e. myownappdir)
- Create the all yaml files (or use one big yaml file) that for the kubernetes deployment that include the following kubernetes resources:
  - Deployment
  - Service
  - Ingress (we are using nginx ingress controller for our local cluster infrastructure)
  - Namespace

```
Use the example apps for reference.

# Clean up
99. Destroy the local cluster/clean up `(execute cluster-cleanup.sh)`

