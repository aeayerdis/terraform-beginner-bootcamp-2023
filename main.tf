terraform {
#   cloud {
#     organization = "aea"

#     workspaces {
#       name = "terra-house-soccer"
#     }
#   }
}

module "terrahouse_aws"{
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name =  var.bucket_name
}