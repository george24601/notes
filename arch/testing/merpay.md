look into their go testframe work - seems mostly for unit and simple int testing

inject error at mysql proxy level - query, exec, commit

check how that proxy is used - injected 

inject http errors - e.g., at when the request completes

for the ease of testability, randomized test makes it much less predictable - so decided by stacktrace(runtime.Callers)

it does not occur twice in the pass once generated

can take advantage of regression test against a fixed input

maybe use fake implementation? the auther used a fake google pub/sub implementation

run your tests on both real and fake to make sure fake behaves same as real

dependent interface is all injected





