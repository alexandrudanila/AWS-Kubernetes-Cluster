# AWS EKS Cluster with Terraform

Production-style Infrastructure as Code project for provisioning an Amazon EKS cluster with Terraform.

The repository manages the AWS networking, IAM roles, Amazon EKS control plane, managed worker node group, Kubernetes access configuration, and remote Terraform state required to operate the cluster from a local workstation using AWS IAM Identity Center (SSO) and `kubectl`.

## Architecture

```text
Local workstation
├── Terraform
├── AWS CLI
├── AWS IAM Identity Center / SSO
└── kubectl
      |
      v
AWS - eu-north-1
├── Amazon VPC
│   ├── Public subnet - AZ 1
│   ├── Public subnet - AZ 2
│   ├── Internet Gateway
│   └── Public Route Table
│
└── Amazon EKS
    ├── AWS-managed Control Plane
    ├── Managed Node Group
    │   ├── Worker Node 1
    │   ├── Worker Node 2
    │   └── Worker Node 3
    ├── Cluster IAM Role
    ├── Worker Node IAM Role
    └── EKS Access Entry
        └── SSO Administrator Role
```

The EKS control plane is fully managed by AWS. Only worker nodes are visible through:

```bash
kubectl get nodes
```

## Key Design Principles

This project follows a simple ownership model:

```text
Terraform = source of truth for AWS infrastructure
kubectl   = management interface for Kubernetes workloads
AWS SSO   = human authentication
```

Amazon EKS is provisioned directly with Terraform resources such as:

```hcl
aws_eks_cluster
aws_eks_node_group
aws_eks_access_entry
aws_eks_access_policy_association
```

This keeps infrastructure lifecycle management centralized in Terraform.

## Project Structure

```text
AWS-Kubernetes-Cluster/
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── .gitignore
├── README.md
└── modules/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── eks/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```


## IAM Roles

### EKS Cluster Role

Used by the Amazon EKS control plane.

Typical policy:

```text
AmazonEKSClusterPolicy
```

### Worker Node Role

Used by the EC2 instances that form the managed node group.

Typical policies:

```text
AmazonEKSWorkerNodePolicy
AmazonEC2ContainerRegistryPullOnly
AmazonEKS_CNI_Policy
```

### Administrator Access Entry

Human access to Kubernetes is configured separately from the service and node IAM roles.

The SSO administrator role is registered as an EKS Access Entry and associated with:

```text
AmazonEKSClusterAdminPolicy
```

Access flow:

```text
AWS IAM Identity Center
        |
        v
AWSReservedSSO_AdministratorAccess_...
        |
        v
EKS Access Entry
        |
        v
AmazonEKSClusterAdminPolicy
        |
        v
Kubernetes API
```

## Prerequisites

Install the following tools locally:

- Terraform
- AWS CLI
- kubectl
- Git

An AWS IAM Identity Center CLI profile named `eks-lab` is used in this project.

Authenticate:

```bash
aws sso login --profile eks-lab
```

Verify the current AWS identity:

```bash
aws sts get-caller-identity --profile eks-lab
```


## Configure kubectl

After the cluster is created, update the local kubeconfig:

```bash
aws eks update-kubeconfig \
  --name eks-lab-cluster \
  --region eu-north-1 \
  --profile eks-lab
```

Verify the active Kubernetes context:

```bash
kubectl config current-context
```


## Useful Commands

```bash
# Authenticate to AWS
aws sso login --profile eks-lab

# Verify AWS identity
aws sts get-caller-identity --profile eks-lab

# Update kubeconfig
aws eks update-kubeconfig \
  --name eks-lab-cluster \
  --region eu-north-1 \
  --profile eks-lab


## Current Result

The project provisions:

- Terraform-managed AWS networking
- Amazon EKS control plane managed by AWS
- managed EKS node group
- three worker nodes
- IAM roles for EKS and worker nodes
- SSO-based EKS administrative access
- remote Terraform state stored in Amazon S3
- direct local cluster administration with `kubectl`

Infrastructure lifecycle:

```
terraform plan
terraform apply
terraform destroy
```

