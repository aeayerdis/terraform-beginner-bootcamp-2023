terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

  
cloud {
    organization = "aea"
    workspaces {
      name = "terra-house-soccer"
    }
  }
}  

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  }

module "home_soccer_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.soccer.public_path
  content_version = var.soccer.content_version
}

resource "terratowns_home" "soccer_home" {
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
  domain_name = module.home_soccer_hosting.domain_name
  #domain_name = "123454.cloudfront.net"
  town = "missingo"
  content_version = var.soccer.content_version
}

# module "home_golf_hosting" {
#   source = "./modules/terrahome_aws"
#   user_uuid = var.teacherseat_user_uuid
#   public_path = var.golf.public_path
#  content_version = var.golf.content_version
  
# }

# resource "terratowns_home" "home2" {
#   name = "How to git gud at golf"
#   description = <<DESCRIPTION
# Practice makes perfect. thats it...just practice before you play and don't build
# bad habits.
# DESCRIPTION
#   domain_name = module.home_golf_hosting.domain_name
#   #domain_name = "123454.cloudfront.net"
#   town = "missingo"
#   content_version = 1
# }