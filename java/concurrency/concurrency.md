#Concurrency and parallelism
Concurrency means that an application is making progress on more than one task at the same time (concurrently).Well, if the computer only has one CPU the application may not make progress on more than one task at exactly the same time, but more than one task is being processed at a time inside the application. It does not completely finish one task before it begins the next.
Parallelism means that an application splits its tasks up into smaller subtasks which can be processed in parallel, for instance on multiple CPUs at the exact same time.

As you can see, an application can be concurrent, but not parallel. This means that it processes more than one task at the same time, but the tasks are not broken down into subtasks.

An application can also be parallel but not concurrent. This means that the application only works on one task at a time, and this task is broken down into subtasks which can be processed in parallel.

Finally, an application can also be both concurrent and parallel, in that it both works on multiple tasks at the same time, and also breaks each task down into subtasks for parallel execution.




# synchronized

A synchronized block in Java is synchronized on some object.

The synchronized keyword can be used to mark four different types of blocks:

Instance methods
Static methods
Code blocks inside instance methods
Code blocks inside static methods

A synchronized instance method in Java is synchronized on the instance (object) owning the method.

every object has a monitor lock, montiorenter and monitorexit



Synchronized static methods are synchronized on the class object of the class the synchronized static method belongs to. Since only one class object exists in the Java VM per class, only one thread can execute inside a static synchronized method in the same class.

The object taken in the parentheses by the synchronized construct is called a monitor object.



1. Mark word in object header,e.g., hashcode, ago, bias, lock tag. Object header = mark word + type pointer

2. an object in addiotn has the instance data and padding

3. JVM will take note of the thread id/adress of Thread pointer  as the owner of the syncrhonzied object

4. for unbias lock, will assign a Lock Record in the stack frame, as copy the object's mark own to each. Whoever wants to access it will change the address of Lock Record into Mark Word

5. for heavyweight lock,e.g., monitor, need to use Mutex from OS. The synched object will point to the created monitor object

6. monitor lock, monitor enter, monitor exit


```
public static synchronized void log1(String msg1, String msg2){
       log.writeln(msg1);
       log.writeln(msg2);
    }

  
    public static void log2(String msg1, String msg2){
       synchronized(MyClass.class){
          log.writeln(msg1);
          log.writeln(msg2);  
       }
    }
```

Only one thread can execute inside any of these two methods at the same time.

Had the second synchronized block been synchronized on a different object than MyClass.class, then one thread could execute inside each method at the same time.

#self-rotate lock?

# re-entrant lock

# readwrite lock


# biased and unbiased lock

# java compare and swap

use it to implement an optimistic lock

Basically, compare and swap compares an expected value to the concrete value of a variable, and if the concrete value of the variable is equals to the expected value, swaps the value of the variable for a new variable.

Modern CPUs have built-in support for atomic compare and swap operations. From Java 5 you can get access to these functions in the CPU via some of the new atomic classes in the java.util.concurrent.atomic package.

# AbstractQueuedSynchronizer
and cas??

#deadlock

Lock ordering is a simple yet effective deadlock prevention mechanism. However, it can only be used if you know about all locks needed ahead of taking any of the locks. This is not always the case.

Another deadlock prevention mechanism is to put a timeout on lock attempts meaning a thread trying to obtain a lock will only try for so long before giving up. If a thread does not succeed in taking all necessary locks within the given timeout, it will backup, free all locks taken, wait for a random amount of time and then retry.

Every time a thread takes a lock it is noted in a data structure (map, graph etc.) of threads and locks. Additionally, whenever a thread requests a lock this is also noted in this data structure.

A better option is to determine or assign a priority of the threads so that only one (or a few) thread backs up. The rest of the threads continue taking the locks they need as if no deadlock had occurred. If the priority assigned to the threads is fixed, the same threads will always be given higher priority. To avoid this you may assign the priority randomly whenever a deadlock is detected.
