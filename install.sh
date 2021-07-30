#!/bin/bash
kubectl create namespace dev
kubectl create configmap jackal-config --from-file=../config/k8s.config.yaml -n dev
kubectl apply -f deployment.yaml -n dev
kubectl apply -f psql-secret.yaml -n dev

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add cetic https://cetic.github.io/helm-charts

helm upgrade --install -n dev --set auth.rbac.enabled="false" etcd bitnami/etcd
helm upgrade --install -n dev psql cetic/postgresql
