When you create an index, CockroachDB "indexes" the columns you specify, which creates a copy of the columns and then sorts their values (without sorting the values in the table itself).

Because each query can use only a single index, CockroachDB selects the index it calculates will scan the fewest rows (i.e., the fastest).

To override CockroachDB's index selection, you can also force queries to use a specific index (also known as "index hinting").
