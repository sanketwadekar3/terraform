region = "ap-south-1"

tags = {

}

create_dms        = true
create_opensearch = true

# ==============================================================
# Variables for EKS
# ==============================================================

EKS = {
  cluster_name            = "eks-cluster-qa"
  endpoint_private_access = true
  k8s_version             = "1.24"

  subnet_ids          = ["subnet-id-1", "subnet-id-2"]
  security_group_ids  = ["sg-id"]
  cluster_iam_role    = "eks-cluster-iam-role-qa"
  node_group_iam_role = "node-group-iam-role-qa"

  node_group = {
    application = {
      name           = "node-group-app-qa"
      desired_size   = 3
      min_size       = 3
      max_size       = 6
      capacity_type  = "ON_DEMAND"
      disk_size      = 50
      ami_type       = "AL2_ARM_64"
      instance_types = ["c6g.2xlarge"]
    },
    api-gw = {
      name           = "node-group-apigw-qa"
      desired_size   = 2
      min_size       = 2
      max_size       = 3
      capacity_type  = "ON_DEMAND"
      disk_size      = 50
      ami_type       = "AL2_ARM_64"
      instance_types = ["c6g.xlarge"]
    }
  }

  tags = {
    "product"           = "infra"
    "Technical-service" = "EKS"
    "env-type"          = "non-prod"
    "sub-env"           = "qa"
  }
}

# ==============================================================
# Variables for EKS Auth
# ==============================================================

EKS_auth = {
  roles = [
    {
      groups   = ["system:masters"]
      rolearn  = "arn:aws:iam::1234567890:role/jenkins-user-role"
      username = "jenkins-user-role"
    },
    {
      groups   = ["system:masters"]
      rolearn  = "arn:aws:iam::1234567890:role/AWSReservedSSO_1234567890"
      username = "AWSReservedSSO_1234567890"
    }
  ],
  users = [
    {

    }
  ]
}

# ==============================================================
# Variables for MSK
# ==============================================================

MSK = {
  cluster_name              = "msk-qa"
  kafka_version             = "2.8.1"
  number_of_broker_nodes    = "2"
  enhanced_monitoring       = "PER_TOPIC_PER_PARTITION"
  client_subnets            = ["subnet-id-1", "subnet-id-2"]
  broker_instance_type      = "kafka.m5.2xlarge"
  security_groups           = ["sg-id"]
  broker_public_access_type = "DISABLED"
  broker_ebs_volume_size    = 100
  client_iam_authentication = true
  tags = {
    "product"           = "infra"
    "Technical-service" = "MSK"
    "env-type"          = "non-prod"
    "sub-env"           = "qa"
  }
}

# ==============================================================
# Variables for RDS
# ==============================================================

RDS = {
  primary = {
    cluster_name              = "aurora-qa"
    engine                    = "aurora-postgresql"
    engine_mode               = "provisioned"
    engine_version            = "14.6"
    database_name             = "postgres"
    port                      = 5432
    backup_retention_period   = 30
    preferred_backup_window   = "01:00-02:00"
    instance_count            = 2
    instance_class            = "db.r6g.2xlarge"
    vpc_security_group_ids    = ["sg-id"]
    subnet_ids                = ["subnet-id-1", "subnet-id-2"]
    deletion_protection       = true
    skip_final_snapshot       = false
    final_snapshot_identifier = "aurora-qa-final-snapshot"

    scaling_configuration              = {}
    serverlessv2_scaling_configuration = {}

    tags = {
      "product"           = "infra"
      "Technical-service" = "RDS"
      "env-type"          = "non-prod"
      "sub-env"           = "qa"
    }
  }
}

# ==============================================================
# Variables for IAM
# ==============================================================

IAM = {
  iam_role = {
    role_name                        = "qa-iam-role"
    policy_name                      = "qa-iam-policy"
    policy_filepath                  = "./env/qa/iam_policies/policy.json"
    allowed_services_for_assume_role = ["dms.amazonaws.com"]
    tags = {

    }
  }
}

# ==============================================================
# Variables for IAM Service Account
# ==============================================================

IAM_service_account = {
  service_account1 = {
    k8s_namespace            = "application"
    k8s_service_account_name = "qa-msk"
    role_name                = "qa-msk-iam-role"
    policy_name              = "qa-msk-iam-policy"
    policy_filepath          = "./env/qa/iam_policies/policy.json"
    tags = {

    }
  },
  autoscaler_service_account = {
    k8s_namespace            = "kube-system"
    k8s_service_account_name = "cluster-autoscaler"
    role_name                = "qa-cluster-autoscaler-iam-role"
    policy_name              = "qa-cluster-autoscaler-iam-policy"
    policy_filepath          = "./env/qa/iam_policies/autoscaler-policy.json"
    tags = {

    }
  }
}

# ==============================================================
# Variables for S3
# ==============================================================

S3 = {
  bucket = {
    bucket_name       = "qa-bucket"
    versioning_status = "Disabled"
    tags = {

    }
  }
}

# ==============================================================
# Variables for DMS
# ==============================================================

DMS = {
  replication_instance_name  = "replication-instance-qa"
  replication_instance_class = "dms.c5.xlarge"
  vpc_security_group_ids     = ["sg-id"]
  engine_version             = "3.4.7"
  subnet_ids                 = ["subnet-id-1", "subnet-id-2"]
  tags = {
    "product"           = "infra"
    "Technical-service" = "DMS"
    "env-type"          = "non-prod"
    "sub-env"           = "qa"
  }
}

# ==============================================================
# Variables for Opensearch
# ==============================================================

Opensearch = {
  domain_name              = "opensearch-qa"
  dedicated_master_count   = 3
  dedicated_master_enabled = true
  dedicated_master_type    = "c6g.2xlarge.search"
  instance_count           = 2
  instance_type            = "r6g.xlarge.search"
  engine_version           = "OpenSearch_2.5"
  security_group_ids       = ["sg-id"]
  subnet_ids               = ["subnet-id-1", "subnet-id-2", "subnet-id-3"]
  zone_awareness_enabled   = true
  zone_awareness_config = {
    availability_zone_count = 3
  }
  volume_size = 1000
  tags = {
    "product"           = "infra"
    "Technical-service" = "Opensearch"
    "env-type"          = "non-prod"
    "sub-env"           = "qa"
  }
}