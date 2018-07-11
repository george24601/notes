def front_op():
    txn1 = begin_txn()
    request_id = create_request(PENDING, txn1)
    pre_action(request_id, txn1)
    commit(txn1)
    middle_status = middle_op(request_id)

"""
need to lock the row, so that no one can modify it! 
double check with your transaction level, most likely read-commited won't work! - 
1. may use MVCC in code - update and then check if affect 
2. use repeatable reads
"""
    txn2 = begin_txn() 

    front_status = get_front_status(request_id)

    if front_state == PENDING:
        if next_status == 200:
            post_action(request_id, txn2)
            update_request_state(request_id, COMPLETED, txn2)
        else:
            rollback_pre_action(request_id)
            #when we update, we need to do a WHERE on PENDING state, as our MVCC
            num_rows_affected = update_request_state(request_id, CANCELLED, txn2)

            if not num_rows_affected: 
                rollback(txn2)
                return
                

    commit(txn2)

def comp_front(request_id):
    middle_comp_status = comp_middle(request_id)

    if middle_comp_state == 200:
        txn = begin_txn()
        front_status = get_front_status(request_id) 
        if front_status == PENDING:
            rollback_pre_action(request_id)
            update_request_state(request_id, CANCELLED, txn2)
        commit(txn) 
    else 
        retry_and_to_dlq(request_id)


