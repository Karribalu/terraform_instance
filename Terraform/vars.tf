variable "AWS_REGION" {
  default = "ap-northeast-1"
}

variable "PRIVATE_KEY_PATH" {
  default = "tokyo-new-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "tokyo-new-key-pair.pub"
}

variable "EC2_USER" {
  default = "ubuntu"
}
variable "AMI" {
  type = map(string)

  default = {
    ap-northeast-1 = "ami-0590f3a1742b17914"
  }
}
