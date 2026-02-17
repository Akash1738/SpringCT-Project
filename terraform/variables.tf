variable "region" {
  default = "us-east-1"
}

variable "s3_bucket" {
  description = "S3 bucket for remote state"
}

variable "dynamodb_table" {
  description = "DynamoDB table for state locking"
}
