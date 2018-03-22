#The most common syntax for here documents, originating in Unix shells, is << followed by a delimiting identifier (often EOF or END), followed, starting on the next line, by the text to be quoted, and then closed by the same delimiting identifier on its own line.

#Appending a minus sign to the << has the effect that leading tabs are ignored. This allows indenting here documents in shell scripts (primarily for alignment with existing indentation) without changing their value

#By default, behavior is largely identical to the contents of double quotes: variables are interpolated, commands in backticks are evaluated, etc. This can be disabled by quoting any part of the label, which is then ended by the unquoted value;[c] the behavior is essentially identical to that if the contents were enclosed in single quotes

#> outputs to a file, >> appends to a file, < reads input from file.

#write multiline to files
cat <<'EOF' >> /etc/awslogs/awscli.conf
[plugins]
cwlogs = cwlogs
[default]
region = ${region}
EOF

