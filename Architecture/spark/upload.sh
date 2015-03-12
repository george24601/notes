SSH_USER=
DEST_HOST=

#setup SSH
#ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
#cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
ssh-copy-id $SSH_USER@$DEST_HOST

#transfer files
scp  -r hadoop-2.6.0/ $SSH_USER@$DEST_HOST:hadoop-2.6.0/
scp -r spark-1.2.1-bin-hadoop2.4/ $SSH_USER@$DEST_HOST:spark-1.2.1-bin-hadoop2.4/
scp -r bootstrap.sh $SSH_USER@$DEST_HOST:bootstrap.sh

ssh  $SSH_USER@$DEST_HOST
