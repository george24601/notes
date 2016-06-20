#monitoring new file
tail -f file

<<COMMENT1
here goes the comment
COMMENT1

#{} to mark the current variable to expand
${PATH}subfolder

#check if port is open and accessible, -z means sending no data, just scanning the daemon
nc -z $HOST $PORT

#delete the folder if it exists, note that the spaces around -d predicate matter!
[ -d $FOLDER ] && rm -r $FOLDER

#log into ssh with identity file, which stores private key for RSA or DSA
ssh -i $CERT $HOST

unzip $FROM -d $TARGET_DIR

host $FIND_IP_OF_HOST

# > vs >>
