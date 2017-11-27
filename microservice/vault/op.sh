vault server -dev

#The only step you need to take is to set the following environment variables:


#the consul prefix specifies which backend to use
vault write secret/hello value=world

vault read secret/hello

vault read -format=json secret/hello

vault delete secret/hello

#mount the kv backend at kv/, use vault mounts to confirm
vault mount kv
