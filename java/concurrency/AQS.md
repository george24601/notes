1. internally, maintains a volatile int state and CLH, and head + tail
2. when acq, state++ if current thread id same as owner id, state-- upon release
3. when failed to acq, AQS will ad the current thread's referenc enad wating tstate to the end of Q as node, and block current thread. Everytime we add to CLH, we nee dto CAS to set tail to the new node
4. difference with fair or biased, is that on biased, cas to acq first, and acq only when failed, and won't detect if CLH is idel
5. shared lock: it becomes head, it will wake up the next thread, upon releasing, SL will wake up other threads regardless of state, but X lock will wake up only when state = 0


