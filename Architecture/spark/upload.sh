SSH_PORT=
SSH_USER=
DEST_HOST=

#transfer files
scp -P $SSH_PORT hadoop-2.6.0.tar.gz $SSH_USER@$DEST_HOST:hadoop-2.6.0.tar.gz
scp -P $SSH_PORT spark-1.2.1-bin-hadoop2.4.tgz $SSH_USER@$DEST_HOST:spark-1.2.1-bin-hadoop2.4.tgz

ssh -p $SSH_PORT $SSH_USER@$DEST_HOST
