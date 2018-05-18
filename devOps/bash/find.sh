#find all .c file starting at the current dir, note find can be chained to other commands too!
#e.g., the dangerous -delete option!
#-iname for case insentivie
find . -name \*.c -print

#find non txt files
find . ! -name "*.txt" -print

#print current dir's files, -type f for files only, d for dir
find . -maxdepth 1 -type f

#log file > 1G
find /var/log -size +1G

find . -mtime +30 -name "*.log" -exec rm -f {} \;


