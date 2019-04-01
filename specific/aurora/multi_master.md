 Amazon Aurora now supports multiple write master nodes across multiple Availability Zones (AZs). Amazon Aurora Multi-Master is designed to allow applications to transparently tolerate failures of any master--or even a service level disruption in a single AZ—with zero application downtime and sub-second failovers. 

 When the 'server' (database node) handles a write, the data is sent in parallel to all 6 storage nodes, and the write is accepted as soon as a quorum of storage nodes (4) writes the data to its redo log and responds. The storage nodes also continuously back up the data to S3 for extra durability.

Multi-master simply scales out the number of 'database nodes' (compute) for handling queries, while keeping the number of storage nodes (and the total write-amplification) constant. In the rare case when conflicting write-transactions occur that can't be resolved locally at either the database or storage layer (e.g., when data changed at both multiple database nodes AND multiple storage nodes), a hierarchical conflict-resolution mechanism is invoked to decide which transaction succeeds and which gets rolled back [2]. This reportedly provides 'near-linear performance scaling when there is no or low levels of conflicts', even when dealing with multiple masters spread across multiple regions

Online DDL performance good

Database is all about IO

network-attached storage is all about packet/sec

high throughput processing is all about context switches
