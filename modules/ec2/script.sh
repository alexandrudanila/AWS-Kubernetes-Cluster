#!/bin/bash
set -e

echo "=== Installing eksctl ==="

curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp

mv /tmp/eksctl /usr/local/bin/eksctl

echo "=== eksctl installed ==="

eksctl version

echo "===== Creating EKS cluster ====="

eksctl create cluster \
  --name ${cluster_name} \
  --nodegroup-name ${nodegroup_name} \
  --node-type ${node_type} \
  --nodes ${desired_nodes} \
  --nodes-min ${min_nodes} \
  --nodes-max ${max_nodes} \
  --version ${kubernetes_version} \
  --region ${aws_region}

echo "===== EKS cluster created ====="