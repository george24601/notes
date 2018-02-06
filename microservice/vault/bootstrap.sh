sudo yum install wget vim nc unzip screen jq

wget https://releases.hashicorp.com/vault/0.9.3/vault_0.9.3_linux_amd64.zip && unzip vault_0.9.3_linux_amd64.zip 

vault -autocomplete-install

###start vault, note we use http here in script and hcl. Don't use it in prod!!!
export VAULT_ADDR='http://127.0.0.1:8200'
#still need to init it
sudo ./vault server -config=vault.hcl

#once per cluster, will give unseal keys and the root token
vault operator init

./vault operator unseal


