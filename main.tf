

module "security-groups-resources" {
  source = "./security-groups-resources" 
}

module "network-resources" {
  source = "./network-resources"
}

module "iam-resources" {
  source = "./iam-resources"
}

module "frontend-launch-template" {
  source = "./launch-templates-resources"
  // Variable definitions
  security_group_id = module.security-groups-resources.frontend_security_group
  iam_instance_profile_name = module.iam-resources.iam_codedeploy_role_name
  public_subnet_id_array = module.network-resources.public_subnet_ids
}
