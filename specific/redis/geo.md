GEOADD key longitude latitude member
Adds the specified geospatial items (latitude, longitude, name) to the specified key. Data is stored into the key as a sorted set

there is no GEODEL command because you can use ZREM in order to remove elements. The Geo index structure is just a sorted set.

Latitude and Longitude bits are interleaved in order to form an unique 52 bit integer. We know that a sorted set double score can represent a 52 bit integer without losing precision.

GEORADIUS key longitude latitude radius: Return the members of a sorted set populated with geospatial information using GEOADD, it is encoded to base 32 or 64 to compare as string

to find nearly, need neighboring grids to consider the border problem

For pagination of georadiusbymember's storedist command to saved the sorted into a zset, follow-up queries go to zset directly. Note redisTemplate may not have support for the storedist param, need to add it ourselves



