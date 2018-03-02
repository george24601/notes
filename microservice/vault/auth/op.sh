#Enable AWS authentication in Vault
vault auth enable aws

#Configure the credentials required to make AWS API calls
vault write auth/aws/config/client secret_key=$AWS_SECRET_ACCESS_KEY access_key=$AWS_ACCESS_KEY_ID


#Configure the policies on the role.
vault write auth/aws/role/ecs-vault-role auth_type=iam \
              bound_iam_principal_arn=arn:aws:iam::433726475936:role/emptyECSTaskRole policies=read-all

#Configure a required X-Vault-AWS-IAM-Server-ID Header (recommended)
vault write auth/aws/config/client iam_server_id_header_value=vault.example.com

###policies###
<<POLICY_HCL
path "secret/*" {
  capabilities = ["read"]
}
POLICY_HCL

vault read sys/policy/read-all

vault write sys/policy/read-all policy=@read-all.hcl

#token defaults to 768H. Although it is debatable to use token access for prod services
vault token create -policy=read-all

