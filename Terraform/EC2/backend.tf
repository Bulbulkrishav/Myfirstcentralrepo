terraform {
  backend "s3" {
    bucket = "bulbul-test-1-us-east-1"
    key    = "tf-ec2-statefile/tf-ec2-statefile.tf"
    region = "us-east-1"
  }
}