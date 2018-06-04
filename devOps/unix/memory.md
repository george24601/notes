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
