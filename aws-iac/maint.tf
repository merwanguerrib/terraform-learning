terraform {
  required_version = ">= 0.12"

  backend "local" {
    path = "mystate.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.50"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">= 0.1"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms" {
  statement {
    sid = "Enable IAM User Permissions"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_key" "my_kms_key" {
  description = "KMS key for S3 bucket encryption"
  policy      = data.aws_iam_policy_document.kms.json
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "mg-unique-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_sse" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.my_kms_key.arn
    }
  }
}

module "s3" {
  source   = "spacelift.io/payfit/s3/aws"
  version  = "2.4.1"
  basename = "my-ultimate-spell"
}
