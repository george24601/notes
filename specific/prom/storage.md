Ingested samples are grouped into blocks of two hours. Each two-hour block consists of a directory containing one or more chunk files that contain all time series samples for that window of time, as well as a metadata file and index file (which indexes metric names and labels to time series in the chunk files).

On average, Prometheus uses only around 1-2 bytes per sample.

each block has an index table

Most of the sections described below start with a len field. It always specifies the number of bytes just before the trailing CRC32 checksum

### index format
* symbol table:list of strings for label pairs 
* series
* list of postings: store monotonically increasing lists of series references that contain a given label pair associated with the list.
* posting offset table: stores a sequence of postings offset entries, sorted by label name and value. Every postings offset entry holds the label name/value pair and the offset to its series list in the postings section. They are used to track postings sections. They are partially read into memory when an index file is loaded. 
* table of content: entry point to the entire index and points to various sections in the file.

### Series
 hold the label set of the series as well as its chunks within the block. The series are sorted lexicographically by their label sets

 Every series entry first holds its number of labels, followed by tuples of symbol table references that contain the label name and value.

 After the labels, the number of indexed chunks is encoded, followed by a sequence of metadata entries containing the chunks minimum (mint) and maximum (maxt) timestamp and a reference to its position in the chunk file.


### chuck
max 512 MB, each record of chuck is len + encoding + data + CRC

### WAL
128MB by default. A segment is written to in pages of 32KB. Mostly borrowed the idea from rocksdb
*type 
*len
*CRC
*data

WAL accepts
* Series records encode the labels that identifies a series and its unique ID
* Sample records encode samples as a list of triples (series_id, timestamp, value)
* Tombstone records encode tombstones as a list of triples (series_id, min_time, max_time)
