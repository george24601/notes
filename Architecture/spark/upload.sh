SSH_PORT=
SSH_USER=
DEST_HOST=

#transfer files
scp -P $SSH_PORT hadoop-2.6.0.tar.gz $SSH_USER@$DEST_HOST:hadoop-2.6.0.tar.gz
scp -P $SSH_PORT jdk-8u31-linux-x64.gz $SSH_USER@$DEST_HOST:jdk-8u31-linux-x64.gz
scp -P $SSH_PORT spark-1.2.1-bin-hadoop2.4.tgz $SSH_USER@$DEST_HOST:spark-1.2.1-bin-hadoop2.4.tgz
scp -P $SSH_PORT bootstrap.sh $SSH_USER@$DEST_HOST:bootstrap.sh

ssh -p $SSH_PORT $SSH_USER@$DEST_HOST
