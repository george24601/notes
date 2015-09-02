from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext, Row
from datetime import date

appName= 'test app'
master= #use "local" to run the local mode

conf = SparkConf().setAppName(appName).setMaster(master)
sc = SparkContext(conf=conf)

#to run the code below from spark shell, use
#./bin/pyspark --master local[4]
#./bin/pyspark --master spark://{master's hostname}:7077

#To submit the file
#./bin/spark-submit --master {master host}[{# of cores}] {this .py's path}

print 'Is basic spark setup working?'
data = [1, 2, 3, 4, 5]
distData = sc.parallelize(data)
distData.map(lambda num: num - 100).first()

testSaveURI=#TODO: put an hdfs:// here

print 'can we save to HDFS?'
distData.saveAsTextFile(testSaveURI)

#invoke hdfs shell 
#bin/hadoop fs <args>

print 'can we access HDFS url?'

distFile = sc.textFile(testSaveURI)

distFile.count()
distFile.first()

distFile.map(lambda line:len(line) - 100).first()

#sparkSQL stars here

rows = distFile.map(lambda line: Row(line=line, lle=len(line)))

#we infer schema here, another approach is to sepcify schema
sqlContext = SQLContext(sc)
schemaRows = sqlContext.inferSchema(rows)
schemaRows.registerTempTable("lc")

testQ = sqlContext.sql("SELECT lle FROM lc")

# The results of SQL queries are RDDs and support all the normal RDD operations.
mapped = testQ.map(lambda r: r.lle)

for r in mapped.collect():
	print r

