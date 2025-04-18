-XX:+PrintCGApplicationStoppedTime

-XX:+PrintSafepointStatistics
-XX:-UseBiasedLocking


### To print GC log
-XX:+PrintGCDetalis 
 -Xlog-gc:/data/jvm/gc.log
 -verbose:gc
-XX:+PrintGCTimeStamps 
-XX:+PrintHeapAtGC


#This will show heap memory, code region, unsafe.allocateMemory, DirectByteBuffer
-XX:NativeMemroryTracking=summary


