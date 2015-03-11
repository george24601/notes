SSH_USER=
DEST_HOST=

#setup SSH
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
ssh-copy-id {user}@{data node hostname}

#transfer files
scp  -r hadoop-2.6.0/ $SSH_USER@$DEST_HOST:hadoop-2.6.0/
scp -r spark-1.2.1-bin-hadoop2.4/ $SSH_USER@$DEST_HOST:spark-1.2.1-bin-hadoop2.4/

ssh  $SSH_USER@$DEST_HOST
