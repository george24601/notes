Offline Migration
------

1. App to read only mode 

2. DB to read only mode

3. Extract A, tranlsate, and load to B

4. Consistency check

5. app to normal mode

6. back up db a

Online Migration
--------

1. Export A's snapshot

2. ETL to b

3. ETL online delta a to b

4. ETL continous consume delta data a to b

5. app stops shortly

6. wait until b's delta consumption is complete

7. DB a readonly mode

8. db consistency check

9. App back to normal R/W mode

10. backup DB a
