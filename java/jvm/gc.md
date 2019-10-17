what is the safe point?

beofre minor gc, compare total size of object in young genwith the CONTINOUS avialalbe sapc in the old gen

concurrent mode failure is caused by the newly promoted objects into the old gen that would trigger the full gc, in this case Serial old is going to be used
new object stays in eden only

old GC is show because: Mark and clean, so we need to move many survival objects, and trackng all GC roots, which are available anyway. Or because the gc roots is small pointing to young gen, it is quick

starts from GC root to mark all live objects
inital tag is from GC roots, and mark only direct references

concurrent mark is from gc roots too, but will follow the reference chain to see which objects are surviors

full gc often accompanies a minor GC, on the first gull gc, if a full gc condition is satisfied due to new object cread, will minor gc and put into the young gen. If the new object can't fit into the memory, have to wait major gc is over.

when full gc is not complete yet another full gc is triggered, we will do serial old

mark and clean vs mark and tidy?

old gen GC marks only garbage?

use serial old to STW and makes sure that we can recycle as much as we can

if eden size > old, need to turn on that gurantee mechanism?

when is minor GC triggered:
1. when eden gen can't fit the new object
2. old gen has enough size to support current suvivors in young gen
3. eden and one survior has not enough space
4. check if all objects LT old gen available space, if so, use minor GC
5. If HandlePromotionFailure is not set, trigger full GC
6. check AVG of minor gc size entering the old gen, if GT cur old gen space, full gc. Otherwise, minor GC

before minor gc
if to survive object size LT survior space, then enter survivor
if between that and old gen space, enter old gen (another case of entering old gen is past the MaxTenuringThreshold)
Otherwise, full gc, and then minor GC

Note that after minor GC, eden is empty

Full gc uses tag and clean up

before minor gc, check all objects size in young gen and cmp with old gen. That is why it is quicker

after reachability test, if no link to GC Roots, it will be amrked first, sn filtered, and check if we need to finalize(), finalize() is the last change object adds a reference - but not recommended to do so. Note that finalize() is guaranteed to execute only once

when are yong gc and full gc triggered?

how is off-heap memory recycled?

G1's remember set, how is that implemented

For large memory, consider using G1, and set expected GC stop time


