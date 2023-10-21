terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  }

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to git gud at soccer"
  description = <<DESCRIPTION
Soccer is so much more than just running and kicking a ball.
It doesn't matter if you're really athletic, if you can follow some basic steps,
it will help you become a better player. Communication is key. Not just when you have
the ball but when you're off the ball as well. Letting your fellow players know what is available
to them and where the defenders are coming in from. Movement off the ball is another key thing
in soccer. Just because you don't have the ball doesn't mean you don't have to make yourself available
to your players who do have the ball. You must always anticipate the sudden shift in the game to be in the 
right positioning!
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "123454.cloudfront.net"
  town = "missingo"
  content_version = 1
}