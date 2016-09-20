// Expectations-First Style (mocks) and Record-then-Verify (stubs). 

// create fakeDb stub that implements PlayerDatabase trait
val fakeDb = stub[PlayerDatabase] 

// configure fakeDb behavior 
(fakeDb.getPlayerById _) when(222) returns(Player(222, "boris", Countries.Russia))
(fakeDb.getPlayerById _) when(333) returns(Player(333, "hans", Countries.Germany))

// use fakeDb
assert(fakeDb.getPlayerById(222).nickname == "boris")


