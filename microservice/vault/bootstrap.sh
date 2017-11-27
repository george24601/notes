wget https://releases.hashicorp.com/vault/0.9.0/vault_0.9.0_linux_amd64.zip && unzip vault_0.9.0_linux_amd64.zip

./vault init

./vault unseal

./vault mount consul

###start vault
export VAULT_ADDR='http://127.0.0.1:8200'
#still need to init it
./vault server -config=vault.hcl

#init auth so that we can use the root token
./vault auth


