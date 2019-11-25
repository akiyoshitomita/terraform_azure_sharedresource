locals {
  common_tags = {
     利用目的 = var.tag_application
     利用者   = var.tag_owner
     期限     = var.tag_expiration
  }  
}
