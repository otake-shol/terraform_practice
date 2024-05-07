# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket  = "tfstate-bucket-otake"
    key     = "tastylog-dev.tfstate"
    region  = "ap-northeast-1"
    profile = "terraform"
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# ---------------------------------------------
# Variables
# ---------------------------------------------
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

# ---------------------------------------------
# IAM ユーザの複数作成
# ---------------------------------------------

// メタ引数利用の練習が目的。本質的に不要な設定
resource "aws_iam_user" "user" {
  count = 2
  name  = "testuser-${count.index}"
}

# ---------------------------------------------
# VPCの複数作成
# ---------------------------------------------
// メタ引数利用の練習が目的。本質的に不要な設定
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/20"
}

resource "aws_subnet" "subnet" {
  for_each = {
    "192.168.1.0/24" = "ap-northeast-1a"
    "192.168.2.0/24" = "ap-northeast-1c"
    "192.168.3.0/24" = "ap-northeast-1d"
  }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.key
  availability_zone = each.value

}

