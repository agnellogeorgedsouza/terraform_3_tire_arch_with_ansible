
terraform {
  backend "s3" {
   bucket = "remotestate-981-ag"
   key = "terraform.tfstate"
   encrypt = "true"
   region = "ap-southeast-1"
 }
}
