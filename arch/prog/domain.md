Surround model and its context with a boundary

Explicitly map between different contexts

model transactional boundaries as aggregates

invariant rules across your domain model - model the invariants and assocaited entity/values as aggregates - aggregates focus on transactional boundaries - individual aggregates are transactional consistent 

between aggregates consistency is relaxed

between bounded contexts, consistency is relaxed

### misc
extension point/plug-in + metadata + CQRS + DDD

how to handle column extension?

service identify verification: tenant id + BizCode, under it multiple extension point

abostract extension point

Use annotation to mark extension, Bootstrap type will scan the class and register the extension 

At run time, use TenantContext to choose the extension, TC is initialized before the business logic, via interceptor

metadata to support extension?

### 58's Entity-Attribute-Value model
common properties goes to table: SKU goes to JSON, less than 50 mil rows per db

ext needs to be self-describing, ext key takes space

get a separate properties service to manage metadata, may need another one for enum types, similar to SKU extension service, this is on top of category + subcategory + ext service
