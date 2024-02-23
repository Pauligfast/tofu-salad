variable "region" {
  description = "AWS region where resources will be created"
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-1234567890abcdef0" 
}