loader 28G/h

loader will use a by default tidb_loader db as checkpoint db

### myloader

The number of threads to use for restoring data, default is 4

Number of INSERT queries to execute per transaction during restore, default
is 1000.

When you execute Myloader, internally it first creates the tables executing the “-schema.sql” files and then takes all the filenames without “schema.sql” and puts them in a task queue. Every thread takes a filename from the queue, which actually is a chunk of the table, and executes it.  When finished it takes another chunk from the queue, but if the queue is empty it just ends.

As you can see, when you have less than 150M rows, import the data and then create the indexes is higher than import the table with the indexes all at once. But everything changes after 150M rows, import 200M takes 64 minutes more for Myloader but just 24 minutes for the new branch.


