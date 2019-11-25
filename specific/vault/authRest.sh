#Enable AWS authentication in Vault
curl -X POST -H "x-vault-token:123" "http://127.0.0.1:8200/v1/sys/auth/aws" -d '{"type":"aws"}'

#Configure the credentials required to make AWS API calls
curl -X POST -H "x-vault-token:123" "http://127.0.0.1:8200/v1/auth/aws/config/client" -d '{"access_key":"VKIAJBRHKH6EVTTNXDHA", "secret_key":"vCtSM8ZUEQ3mOFVlYPBQkf2sO6F/W7a5TVzrl3Oj"}'

#Configure the policies on the role.
curl -X POST -H "x-vault-token:123" http://127.0.0.1:8200/v1/auth/aws/role/dev-role -d '{"bound_ami_id":"ami-fce3c696","policies":"prod,dev","max_ttl":"500h"}'

curl -X POST -H "x-vault-token:123" http://127.0.0.1:8200/v1/auth/aws/role/dev-role-iam -d '{"auth_type":"iam","policies":"prod,dev","max_ttl":"500h","bound_iam_principal_arn":"arn:aws:iam::123456789012:role/MyRole"}'


#Perform the login operation
curl -X POST "http://127.0.0.1:8200/v1/auth/aws/login" -d '{"role":"dev-role","pkcs7":"'$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/pkcs7 | tr -d '\n')'","nonce":"5defbf9e-a8f9-3063-bdfc-54b7a42a1f95"}'

