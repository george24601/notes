<<SHORTCUTS
Ctrl + e – go to the end of the command line

Ctrl + k – delete from cursor to the end of the command line

Ctrl + u – delete from cursor to the start of the command line

Ctrl + w – delete from cursor to start of word (i.e. delete backwards one word)
SHORTCUTS
#delete the folder if it exists, note that the spaces around -d predicate matter! 
[ -d $FOLDER ] && rm -r $FOLDER

#But -d does not work with wildcards!
if ls /path/to/your/files* 1> /dev/null 2>&1; then
      echo "files do exist"

#search only files with certain extensions
grep -r --include=*.scala 'spray' ./ | less

#find all .c file starting at the current dir, note find can be chained to other commands too!
find . -name \*.c -print

#compress and decompress, -c compress, -x extract
tar -czvf $TO.tar.gz $FROM

#display error code of the last command,e.g., use it after a semicolon 
echo $?
#similarly, !$ is the last argument of the previous command
cd !$

#use of CDPATH, probably what to edit your ~/.bashrc

#automatically corrects small typos in directory names and jumps to the best guess of existing directories.
shopt -s cdspell

<<OTHER
#pushd and popd for quick dir navigation

#Press Control+R and type the keyword to search for command history

#exeute 4th command from the history
!4
OTHER

#the {} in ${} are useful if you want to expand the variable foo in the string, e.g.,
${foo}bar

#shell to exit if any subcommand or pipeline returns a non-zero status
#set -e
