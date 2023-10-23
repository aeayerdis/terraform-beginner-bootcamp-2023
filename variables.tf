variable "teacherseat_user_uuid" {
 type = string
}

variable "terratowns_access_token" {
 type = string
}

variable "soccer" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "golf" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "terratowns_endpoint" {
  description = "Terratowns URL"
  type = string
}