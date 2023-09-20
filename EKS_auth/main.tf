locals {
  merged_map_roles = distinct(concat(
    var.aws_auth_map_role, var.roles
  ))
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.merged_map_roles)
    mapUsers = yamlencode(var.users)
  }

  force = true
}