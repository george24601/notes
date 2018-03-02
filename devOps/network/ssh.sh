#log into ssh with identity file, which stores private key for RSA or DSA
ssh -i $CERT $HOST

#list added certificates
ssh-add -l

#add cerficicate to the agent
chmod 400 ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa



