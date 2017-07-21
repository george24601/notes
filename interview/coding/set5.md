Problem A
--------
There's a new language which uses the latin alphabet. However, you don't know the order among letters. 

It could be: 
a b c d ... 

as it could also be: 

b e z a m i ... 

You receive a list of words lexicographically sorted by the rules of this new language. From this list, derive one valid particular ordering of letters in this language.


Problem B
---------
Write a program that answers YES/NO search queries containing * placeholders. Example: if the data you have is (hazem, ahmed, moustafa, fizo), then you should answer as follows for: 
```
 ahmed: YES 
 m**stafa: YES 
 fizoo: NO 
 fizd: NO 
 *****: YES 
 ****: YES  
**: NO 
```
 Your program should be able to answer each search query in O(1).


Problem C
----------
Given a dictionary of words, return an array of the words whose match. (i.e. pattern "c.t" match with "cat", "cut", etc. because the dot notation stand for ANY character). 


Problem D
---------
Having a home-defined linked list with the following structure, where the next will point to the next node in the list and the random will point to a random node in the list (not null). 
Create a copy of the structure (the data field in each node is not unique for different nodes): 

	```
	Example: 
	Having the list: 
	1 -> 2 -> 3 -> X 
	With random pointers to: 
	1: 3 
	2: 2 
	3: 1 

	Create the list: 
	1' -> 2' -> 3' -> X 
	1': 3' 
	2': 2' 
	3': 1' 

	class Node { 
		int data; 
		Node next; 
		Node random; 
	}
```
