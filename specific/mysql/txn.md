mvcc: row_trx_id for each data row

each txn has an array to keep track of active txn ids when this txn is created

when renew: the data is read first and then update -> this is called current read

CR is the heart of RR, when update, ONLY current read, if current recond's row lock is used, waited

as a comparions, RC will calculate a new view before EVERY statement executes

normal read is CR, uses row txn id and consistency view to verify version's visbility
