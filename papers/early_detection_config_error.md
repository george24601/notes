During system init, validate configs used in later execution or special circumstances

Verify that configs that works. On system init, verify ALL config parameters it uses, and fail-fast if any required ones failed. Otherwise, they will fail when you invoke them, experience shows often this happens when you need them most,i.e., detecting them wil be too late to limit the failure damage

What is worse, most configs are used purely for error-handling, this means the error-handling module itself will fail -> cacading effect, and unit testing can not detect it!

missing permission for the path is common for core-dump failure during crash

Some Java programs put the checking or usage code of the parameters in the class constructors, so that the errors can be exposed when the class objects are created (specially, this is used as the practice for quickly fixing LC errors


