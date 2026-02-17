terraform {
  backend "s3" {
    bucket = "springct-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
