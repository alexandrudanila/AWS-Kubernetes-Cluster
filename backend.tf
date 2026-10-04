terraform {
  backend "s3" {
    bucket  = "eks-lab-backend"
    key     = "eks-lab/terraform.tfstate"
    region  = "eu-north-1"
    profile = "eks-lab"

    encrypt      = true
    use_lockfile = true
  }
}