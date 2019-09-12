TLmap's key weak refs to a TL instance, but the value is refered by the currentThread, so you may have many entries with key = null(key is GCed already), the value will be GCed only when current thread is over, i.e., CurrentTHread -> TLMap -> Entry -> value. Part of the reason TL will clear all entries where key = null on get, set, and remove

threadRef->currentThread->threadLocalMap->entry->valueRef->valueMemory , if the thread terminates, we are good
however, if the it is threadpooled, the thread never terminates -> we got problem!
How do we defend against this problem?
