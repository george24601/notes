#log into ssh with identity file, which stores private key for RSA or DSA
ssh -i $CERT $HOST

#list added certificates
ssh-add -l

#add cerficicate to the agent
ssh-add -K ~/.ssh/id_rsa

#go directly to host wanted
ssh -t $HOST "cd /directory_wanted ; bash"
