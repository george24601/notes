# -R recursive
# -v verbose

#read and write by file owner
#read and write by group
#read only by other user
chmod 664 sharedFile

#show permision, or just ls -l
stat -c %a findPhoneNumbers.sh

#-rwxr-xr--
#leading hyphen: plain file
#each 3 letters, file owner, group, other user
#every file on linux is owned by a user and a group




