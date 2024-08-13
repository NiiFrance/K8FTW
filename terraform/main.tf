module "iam_resources" {
  source = "./modules/iam"
  
  name_prefix    = "prod-ci"
  use_name_suffix = true
}

output "role_arn" {
  value = module.iam_resources.role_arn
}

output "user_name" {
  value = module.iam_resources.user_name
}