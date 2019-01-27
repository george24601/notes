executor maxThreads 500, minSpareThreads = 20, maxIdleTIem = 60000

min/maxProcessors: # of threads that can be created

need to disable AJP

after OS finished init HS with the client, the connection will be put into the accept queue, and tomcat will take from the accept queue. 

When Acceptor accepts a socket, it will first send to Poller, Poller maintains selector, which be registered with the sockets. Poller will then iterator through slector, find readable socket,and user Worker thread to process corresponding request

This menas Acceptr accept socket or thread processing request are still in blocking modeIn NIO 

acceptCount: length of acceptor queue, default 100. new conns will be dropped when the queue is full

maxConnecitons: Acceptor will not read from the accept queue if # of conns > this #, default 10000 for NIO

maxThreads: default 200, request processing thread's max #, ignored fi the Connector has a bound executor

Normally init heap size is same as max heap size, to avoid full GC when the init memory is not enough
