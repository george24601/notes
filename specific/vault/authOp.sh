####bootstrap#####
vault auth enable aws

vault write auth/aws/config/client secret_key=$AWS_SECRET_ACCESS_KEY access_key=$AWS_ACCESS_KEY_ID

#Configure a required X-Vault-AWS-IAM-Server-ID Header (recommended)
vault write auth/aws/config/client iam_server_id_header_value=vault.example.com


###IAM based###
cat > read-all.hcl <<- EOF
path "secret/link/*" {
  capabilities = ["read"]
}

path "secret/link" {
  capabilities = ["read"]
}

path "secret/application/$ENV" {
  capabilities = ["read"]
}

path "secret/application" {
  capabilities = ["read"]
}
EOF

vault write sys/policy/read-all policy=@read-all.hcl
vault read sys/policy/read-all

vault write auth/aws/role/$IAM_ROLE auth_type=iam \
              bound_iam_principal_arn=$BOUND_IAM_PRINCIPAL_ARN policies=read-all


vault read auth/aws/role/$IAM_ROLE



########token based

#token defaults to 768H. Although it is debatable to use token access for prod services
vault token create -policy=read-all

