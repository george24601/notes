#log into ssh with identity file, which stores private key for RSA or DSA
ssh -i $CERT $HOST

#list added certificates
ssh-add -l

#add cerficicate to the agent
chmod 400 ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa

#opens a connection to the gw.example.com jump server, and forwards any connection to port 80 on the local machine to port 80 on intra.example.com.
ssh -L 80:intra.example.com:80 gw.example.com

#jump via jump host, make sure ssh-add .pem first!
ssh -tt -A ec2-user@$PUBLIC_JUMP ssh -tt ec2-user@$PRIVATE_JUMP
