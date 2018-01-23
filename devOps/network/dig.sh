<<DATA
the answer section:

name                 expire  class   type     data (IP)

You can ignore the "class" field; this is nearly always IN for Internet.

The AUTHORITY section contains records of type NS, indicating the names of DNS servers that have name records for a particular domain.

The rd (recursion desired) flag indicates that dig requested a recursive lookup, and the ra (recursion available) flag indicates that the server permits recursive lookups (some do not).
DATA
#trace will show all steps
dig +trace wikipedia.org


<<RECUR
dig only prints the final result of the recursive search. You can mimic the individual steps of a recursive search by sending a request to a particular DNS server and asking for no recursion, using the +norecurs flag. For example, to send a non-recursive query to one of the root servers:
RECUR
dig @a.ROOT-SERVERS.NET www.wikipedia.org +norecurs

#txt record type is special => need to specify type explicitly
dig -t txt YOUR_TXT_DNS_NAME


#check source of Authority with forward resolver
dig SOA +multiline $DOMAIN_NAME 
