terraform {
  backend "s3" {
    bucket         = "infrastructure-state2"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}