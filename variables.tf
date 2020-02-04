provider "aws" {
  access_key = "AKIARQXYJJ3NAKIF3YFG"
  secret_key = "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"
  region     = "us-west-2"
}

variable "access_key" {
  description = "AWS access key"
  default     = "AKIARQXYJJ3NAKIF3YFG"
}

variable "secret_key" {
  description = "AWS secret key"
  default     = "ztDK2s/gIZ/46xZxL84uZEYtBkNOikZyBm3dnD9e"
}

variable "region" {
  description = "AWS region for hosting our your network"
  default     = "us-west-2"
}

variable "availability_zones" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "key_path" {
  description = "Key path for SSHing into EC2"
  default     = "/Users/aaronescoto/.ssh/aescoto.pem"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default     = "aescoto"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.0.2.0/24"
}

variable "amis" {
  description = "Base AMI to launch the instances"
  default = {
    us-west-2 = "ami-04590e7389a6e577c"
  }
}
