# synchronized

1. Mark word in object header,e.g., hashcode, ago, bias, lock tag. Object header = mark word + type pointer

2. an object in addiotn has the instance data and padding

3. JVM will take note of the thread id/adress of Thread pointer  as the owner of the syncrhonzied object

4. for unbias lock, will assign a Lock Record in the stack frame, as copy the object's mark own to each. Whoever wants to access it will change the address of Lock Record into Mark Word

5. for heavyweight lock,e.g., monitor, need to use Mutex from OS. The synched object will point to the created monitor object

