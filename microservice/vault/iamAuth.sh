vault auth enable aws

vault write auth/aws/config/client secret_key=$SECRET_KEY access_key=$ACCESS_KEY
