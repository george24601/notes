<<COMMENT
follows the format pattern { action }

print appends a newline. $0 is the entire line

COMMENT

#The special variable, NF, contains the number of fields in the current line. I can print the last field by printing the field $NF or I can just manipulate that value to identify a field based on it's position from the last
echo 'this is a test' | awk '{print $NF}'  // prints "test"
awk '{print $1, $(NF-2) }' logs.txt


#$8 eighth field of the input line
BEGIN { print "File\tOwner"}
{ print $8, "\t", $3}
END { print " - DONE -" }

#Another cool variable is NR, which is the row number being currently processed.
awk '{print NR ") " $1 " -> " $(NF-2)}' logs.txt

awk '{if ($(NF-2) == "200") {print $0}}' logs.txt

awk '{a+=$(NF-2); print "Total so far:", a}' logs.txt

#print stuff after processing the final line using an END clause
awk '{a+=$(NF-2)}END{print "Total:", a}' logs.txt


#unlike the shell (and PERL) AWK does not evaluate variables within strings. 
#In scripting languages like Perl and the various shells, a dollar sign means the word following is the name of the variable. Awk is different. The dollar sign means that we are refering to a field or column in the current line. When switching between Perl and AWK you must remener that "$" has a different meaning. So the following piece of code prints two "fields" to standard out. The first field printed is the number "5", the second is the fifth field (or column) on the input line.
BEGIN { x=5 }
{ print x, $x}

#how to use them for splitting on a different delimiter.
awk '{print $2}' logs.txt | awk 'BEGIN{FS=":"}{print $1}' | sed 's/\[//'


