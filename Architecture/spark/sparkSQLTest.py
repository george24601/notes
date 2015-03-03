from pyspark.sql import SQLContext, Row

appName= 'test app'
master= #use "local" to run the local mode

conf = SparkConf().setAppName(appName).setMaster(master)
sc = SparkContext(conf=conf)

sqlContext = SQLContext(sc)

#all operations are done on schemaRDD, which can be from existing RDD, a Parquetfile, JSON, or HiveSQL result set


#to convert to schemaRDD, either infer schema or construct schema yourselves

URI="examples/src/main/resources/people.txt" #TODO:CHANGE THIS

lines = sc.textFile(URI)
parts = lines.map(lambda l: l.split(","))
people = parts.map(lambda p: Row(name=p[0], age=int(p[1])))

# Infer the schema, and register the SchemaRDD as a table.
schemaPeople = sqlContext.inferSchema(people)
schemaPeople.registerTempTable("people")

teenagers = sqlContext.sql("SELECT name FROM people WHERE age >= 13 AND age <= 19")

# The results of SQL queries are RDDs and support all the normal RDD operations.
teenNames = teenagers.map(lambda p: "Name: " + p.name)
for teenName in teenNames.collect():
  print teenName
