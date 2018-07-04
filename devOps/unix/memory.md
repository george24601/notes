When executing a program from terminal, the terminal process use exec to load executable into memory, now code, data, bbs, stack, are mapped into the memory space via mmap, heap may map depending on if the you applied for the memory on the heap

exec will pass the control of CPU to dynamic linker linker, which will load the dynamically linked libary into memeory, and then execution starts. For more details, use strace

When malloc(), will use brk() to enter kernel mode, and see if we have heap's VMA, if not, use mmap to map some memory to heap, and create vmaa, and assign it to mm_struct's red-black tree and linked-list

back to user-mode, use memory allocator to manage allocated memory,a dn return the required memmory to the user

If the user applies for big memory, use mmap to allocate directly, which will return virtual memory, memory will be assigned only when the returned memory is firstly visited

brk returns virtual memory too, but they are assigned to physical memory already

when the process uses free to release memory, if it is assigned mmap, use munmap directly. Otherwiser, the memory is returned to the memoery allocation, which will return to the system later.

Physical memory has cache and normal physical memory - can check with free

mmap -> file mapping, and anyomnous mapping

1. shared file mapping. two processes for the same same exectutable share file -> mapped to the same physical memory.  file is read into cache, and then mapped into user process space

2. private file mapping. for the data segments within the process space. when in this most, file to cache first, if some file is changing  this file, will allocate a memory and copy the file into the newly allocated memory, and then change the newly allocated memory.

3. private anonymous mapping, bbs, stack, heap are anonymous mapping, because exetuable doesn't have correspoidng segment, and must be private

4. shared anonymous mapping, apply memory from cache

why do we need second-level VM mapping table?

what does buffer and cache in free mean?

# segmentation of symbol table, source text, constant, parse tree, and call stack

# Memory-mapping file

in most operating systems the memory region mapped actually is the kernel's page cache (file cache), meaning that no copies need to be created in user space

Persisted files are associated with a source file on a disk. The data is saved to the source file on the disk once the last process is finished. These memory-mapped files are suitable for working with extremely large source files

Non-persisted files are not associated with a file on a disk. When the last process has finished working with the file, the data is lost. These files are suitable for creating shared memory for inter-process communications (IPC)

Only hardware architectures with an MMU can support memory-mapped files

Another common use for memory-mapped files is to share memory between multiple processes

In some of those systems, it is common to dedicate an entire partition of a hard disk to swapping. These partitions are called swap partitions. Many systems have an entire hard drive dedicated to swapping, separate from the data drive(s), containing only a swap partition. A hard drive dedicated to swapping is called a "swap drive" or a "scratch drive" or a "scratch disk". Some of those systems only support swapping to a swap partition; others also support swapping to files.