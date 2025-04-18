native memory avoids the copying between  java heap and native heap

The frame data must also contain some kind of reference to the method's exception table, which the virtual machine uses to process any exceptions thrown during the course of execution of the method. An exception table, which is described in detail in Chapter 17, "Exceptions," defines ranges within the bytecodes of a method that are protected by catch clauses. Each entry in an exception table gives a starting and ending position of the range protected by a catch clause, an index into the constant pool that gives the exception class being caught, and a starting position of the catch clause's code.

When a method throws an exception, the Java virtual machine uses the exception table referred to by the frame data to determine how to handle the exception. If the virtual machine finds a matching catch clause in the method's exception table, it transfers control to the beginning of that catch clause. If the virtual machine doesn't find a matching catch clause, the method completes abruptly. The virtual machine uses the information in the frame data to restore the invoking method's frame. It then rethrows the same exception in the context of the invoking method.

Like references to fields and methods of other classes, references to the fields and methods of the same class are initially symbolic and must be resolved before they are used.

To invoke the addTwoTypes() method, the addAndPrint() method first pushes an int one and double 88.88 onto its operand stack. It then invokes the addTwoTypes() method.

The virtual machine allocates enough memory for the addTwoTypes() frame from a heap. It then pops the double and int parameters (88.88 and one) from addAndPrint()'s operand stack and places them into addTwoType()'s local variable slots one and zero.

When addTwoTypes() returns, it first pushes the double return value (in this case, 89.88) onto its operand stack. The virtual machine uses the information in the frame data to locate the stack frame of the invoking method, addAndPrint().

It pushes the double return value onto addAndPrint()'s operand stack and frees the memory occupied by addTwoType()'s frame. It makes addAndPrint()'s frame current and continues executing the addAndPrint() method at the first instruction past the addTwoType() method invocation.

another implementation, Note that the operand stack of the current frame is always at the "top" of the Java stack. Although this may be easier to visualize in the contiguous memory implementation

. In the remainder of this book, "pushing a value onto the stack" refers to pushing a value onto the operand stack of the current frame.

the stack also has reference to the dynamic linking information

Out of memory possible if sum of stack + heap + method are > available physical memory


