hdfs dfsadmin -report | more

yarn node -list -all

hadoop fs -put stocks.csv

hadoop fs -ls

hdfs fsck /user/root/stocks.csv -files -blocks -locations

hadoop fs -getmerge test /tmp/merged.txt

#read from stdin
hadoop fs -put - myinput.txt

