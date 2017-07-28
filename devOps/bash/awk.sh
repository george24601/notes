#follows the format pattern { action }

#$8 eighth field of the input line
BEGIN { print "File\tOwner"}
{ print $8, "\t", $3}
END { print " - DONE -" }

#unlike the shell (and PERL) AWK does not evaluate variables within strings. 
#In scripting languages like Perl and the various shells, a dollar sign means the word following is the name of the variable. Awk is different. The dollar sign means that we are refering to a field or column in the current line. When switching between Perl and AWK you must remener that "$" has a different meaning. So the following piece of code prints two "fields" to standard out. The first field printed is the number "5", the second is the fifth field (or column) on the input line.
BEGIN { x=5 }
{ print x, $x}

#And again, once it is created, it has to be made executable:
chmod +x awk_example1.sh

#You need to turn off the quoting when the variable is seen. This can be done by ending the quoting, and restarting it after the variable: 

#ls -l | Column 3
#!/bin/sh
column=$1
awk '{print $'$column'}'

#in shell ${variable:-defaultvalue}
