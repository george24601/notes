### module 1
* Give an example on how rows are stored in tikv, one for data row, one for the index
* Each tidb region is 96MB, compare and contrast with the block size decision in other storage systems
* Describe region split process
* IRC, TiDB v2 and v3 changed the query execution model. If so, please explain the difference
* What is the role of the coprocessor? Explain its workflow

### Module 2.1
* Why is raft log identified by both log index and the term at the same time
* Explain raft leader election process
* How does new leader handle the old uncommited logs from the old leader
* Explain the two phase merge process

### 2.2
* What metadata is stored in PD?
* How does TSO work? (slide didn't cover enough)
* What is the role of Label? (slide prob didn't cover enough)

### 2.3
* Explain phatom read and the solution
* Explain's Percolator's 2PC model
* Explain how percolator's 2PC maps to entries in RocksDB
* Explain tidb's 2PC sequence of actions


### 4.2
* Explain the binlog format and its content (Slides prob didn't cover enough).
* How tidb writes binlog, including its sequence of actions?
* How does drainer work?

### 5.1.1
* Explain SQL layer architecture

### 5.1.2
* Explain the vectorized execution model
