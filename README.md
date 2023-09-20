## Terraform Commands to be used :

#### Initialised terraform and setting backend configuration
`terraform init --backend-config="./env/{ENV}/backend.tf"`

#### To see the entire plan and configuration of resources to be created
`terraform plan --var-file="./env/{ENV}/values.tfvars"`

#### To see if the configuration is valid or not
`terraform validate`

#### To format all the terraform files
`terraform fmt -recursive`

#### To apply the terraform code to the resp. Environment
`terraform apply --var-file="./env/{ENV}/values.tfvars -auto-approve`