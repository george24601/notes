#symlink
ln -s $FILE_PATH $LINK_PATH

#check if port is open and accessible, -z means sending no data, just scanning the daemon
nc -z $HOST $PORT

#delete the folder if it exists, note that the spaces around -d predicate matter! 
[ -d $FOLDER ] && rm -r $FOLDER

#But -d does not work with wildcards!
if ls /path/to/your/files* 1> /dev/null 2>&1; then
      echo "files do exist"

host $FIND_IP_OF_HOST

#search only files with certain extensions
grep -r --include=*.scala 'spray' ./ | less

#find all .c file starting at the current dir, note find can be chained to other commands too!
find . -name \*.c -print

#compress and decompress, -c compress, -x extract
tar -czvf $TO.tar.gz $FROM
