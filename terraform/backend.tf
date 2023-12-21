terraform {
    backend "s3" {
        bucket = "devops-tf-state-newrelic-bucket"
        key = "tf-state-file/terraform.tfstate"
        region = "eu-north-1"
        dynamodb_table = "terraform-newrelic-state-locking"
        encrypt = true
    }
}