###policies###
<<POLICY_HCL
path "secret/*" {
  capabilities = ["read"]
}
POLICY_HCL

vault read sys/policy/read-all

vault write sys/policy/read-all policy=@read-all.hcl
#Enable AWS authentication in Vault
vault auth enable aws

#Configure the credentials required to make AWS API calls
vault write auth/aws/config/client secret_key=$AWS_SECRET_ACCESS_KEY access_key=$AWS_ACCESS_KEY_ID

vault read auth/aws/role/ecs-vault-role 

#Configure the policies on the role.
vault write auth/aws/role/ecs-vault-role auth_type=iam \
              bound_iam_principal_arn=$BOUND_IAM_PRINCIPAL_ARN policies=read-all

#Configure a required X-Vault-AWS-IAM-Server-ID Header (recommended)
vault write auth/aws/config/client iam_server_id_header_value=vault.example.com

########token based

#token defaults to 768H. Although it is debatable to use token access for prod services
vault token create -policy=read-all

