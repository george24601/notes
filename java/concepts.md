Example of type unchecked warning,e.g.,  List<String> rawList = new ArrayList()

class type.newInstance, ConstructorType.newInstance - classType newInstance calls reflection constructor type's parameter-less methods

add/remove inside foreach =>may get concurrency exception even when single threaded due to the check inside iterator!

use classloader isolation for jar version conflict

async worker, exception handling problem

### From alibaba's conventions

* table name and DO name should be singular, 
* unique index name should be uk_, indices start with idx_
* table must have 3 columns, id, created_at, updated_at (use datetime type)
* two table join is OK but be careful. More than 3 tables are NOT allowed
* Not allowed to return hashmap directly, because they had problem deserializing bigint object

how to delete element in a list?

ArrayList: DEAULT_CAPCITY=10, will copy with 50% increased capacity. Part of the reason init size is recommended to be set

why no enum type as API return type?
