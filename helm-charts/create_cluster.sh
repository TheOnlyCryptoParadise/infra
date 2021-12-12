#!/bin/bash

# kind create cluster --config=cluster_config.yml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
# kubectl wait --namespace ingress-nginx \
# --for=condition=ready pod \
# --selector=app.kubernetes.io/component=controller \
# --timeout=120s
# echo "apply configs"
# kubectl apply -f kubectl-configs

minikube start --extra-config=apiserver.service-node-port-range=1-65535