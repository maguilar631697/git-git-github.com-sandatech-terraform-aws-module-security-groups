###### rd ######
data "terraform_remote_state" "vpc-rd-us-east-1" {
  backend = "remote"
  
  config = {
    organization = "sandata-tech"
    workspaces = {
      name = "sandata-rd-us-east-1-vpc-network"
    }
  }
}