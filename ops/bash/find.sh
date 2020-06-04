
# find large file, then use echo "" > a.log to clear the log
find / -type f -name "*log*" | xargs | s-lSh | more 
du -a / |sort -rn |grep log | more
find / -name '*log*' -size +1000M -exec du -h {}\'

#find all .c file starting at the current dir, note find can be chained to other commands too!
#e.g., the dangerous -delete option! Similarly, -exec option is dangerous too!
#-iname for case insentivie
#the second directory is the dir find operates on
find . -name \*.c -print

#find non txt files
find . ! -name "*.txt" -print

#print current dir's files, -type f for files only, d for dir
find . -maxdepth 1 -type f

#log file > 1G
find /var/log -size +1G

find . -mtime +30 -name "*.log" -exec rm -f {} \;

#fin all test.php in the current working dir
find -type f -name test.php

#find all executable file
find / -perm /a=x

#files changed in the last 60 mins
find / -cmin -60
