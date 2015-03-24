from pyspark.sql import SQLContext, Row
from pyspark import SparkContext, SparkConf

appName= 'test app'
master= #use "local" to run the local mode

conf = SparkConf().setAppName(appName).setMaster(master)
sc = SparkContext(conf=conf)

sqlContext = SQLContext(sc)

#all operations are done on schemaRDD, which can be from existing RDD, a Parquetfile, JSON, or HiveSQL result set

#to convert to schemaRDD, either infer schema or construct schema yourselves

# a bigger table
URI=#TODO: change this into hdfs://...
lines = sc.textFile(URI)

data = lines.map(lambda l: l.split(",")).map(lambda p: Row(value=int(p[4]), payee=p[3])) # a 5 column table. NOTE: how do we handle date?

schemaData = sqlContext.inferSchema(data)
schemaData.registerTempTable("data")

resultSet = sqlContext.sql("SELECT payee p1, SUM(value) v FROM data GROUP BY payee").map(lambda p:[p.p1, p.v]) #NOTE: SUM(value) needs aliasing

for result in resultSet.collect():
	print result[0] + ',' + str(result[1])
