* StringBuilder vs StringBuffer
  * StringBuffer is threadsafe
  * StringUtils.join uses StringBuilder too
* Why no isSuccess var name?
  * In Java Bean spec, the boolean type method must be isProperty.
  * isSuccess var name may confuse different serialization/deserialization framework
  * As per alibaba recommendation, POJO member properteis must be packaged type, and local var uses basic type, so that you get NPE early instead unexpected null
* Proper ex handling should have local context and stack race, or re-throw
```java
logger.error(param, object strings + "_" + e.getMessage(), e)
```

Example of type unchecked warning,e.g.,  List<String> rawList = new ArrayList()

class type.newInstance, ConstructorType.newInstance - classType newInstance calls reflection constructor type's parameter-less methods

### From alibaba's conventions

* table name and DO name should be singular, 
* unique index name should be uk_, indices start with idx_
* table must have 3 columns, id, created_at, updated_at (use datetime type)
* two table join is OK but be careful. More than 3 tables are NOT allowed
* Not allowed to return hashmap directly, because they had problem deserializing bigint object

ArrayList: DEAULT_CAPCITY=10, will copy with 50% increased capacity. Part of the reason init size is recommended to be set

why no enum type as API return type? If the callee extends a new enum type, the caller will have serialization error. This is similar to convariant - contravariant rule. Enum is a good point as params. One can compare this to the robustness principle of communication: "be liberal in what you accept and conservative in what you produce.

Array extends the size by 1.5 times, default size to 10, i.e., will increase size to 10, on the first write. Every time resize, a complete copy is required

string's hashcode is a rolling hash,with factor 31, i.e., 31-based char-number . We pick 31 because it is prime, and can convert mult into bit operation

### Code layers
Controller: param verification, exception handling
Service: normally one service per controller, hard to reuse
Manager: reusable logic 
DAO: data access object

highlly recommend NOT to use Optional as the param type
don't option on the collection type
