from pyspark import SparkContext, SparkConf

appName= 'test app'
master= #use "local" to run the local mode

conf = SparkConf().setAppName(appName).setMaster(master)
sc = SparkContext(conf=conf)

#to run the code below from spark shell, use
#./bin/pyspark --master {master host}[{# of cores}]

#To submit the file
#./bin/spark-submit --master {master host}[{# of cores}] {this .py's path}

print 'Is basic spark setup working?'
data = [1, 2, 3, 4, 5]
distData = sc.parallelize(data)

print 'can we access HDFS url?'
#invoke hdfs shell 
#bin/hadoop fs <args>

hdfsURI = 'hdfs://namenodehost/parent/child'

print hdfsURI

distFile = sc.textFile(hdfsURI)

print 'can we save to HDFS?'
distFile.saveAsSequenceFile(hdfsURI+ '_copy')
