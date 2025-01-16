variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "ap-northeast-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-062cf18d655c0b1e8"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.medium"
}

variable "key_name" {
  description = "Key pair name for EC2 access"
  default     = "key_name"
}

