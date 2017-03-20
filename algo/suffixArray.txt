trie: each of its node will have a number of sons equal to the size of the alphabet used by the strings

suffix tree: compress all suffixes of A1...An-1 into a tree

Operation: 
1. checking whether a string W is a substring of A
2. longest common prefix for two suffixes of A: choose nodes u and v in the trie, correspnondg to the ends of the two suffixes, use LCA to
find the node correspondng to the end of the searche prefix
3. Find the k-th suffix in lexicographi order => just check the leaf order 

Note that if we do a DFS on the trie, we produce nodes in the ascending lexicographic order of the edges => so we just maintain the index of
every suffix in the sorted array

e.g. "abac"'s suffix array is (0,2, 1, 3)


Build suffix array
-----------
maintain the order of the string's suffixes sorted by their 2^k long prefixes , compute the order of teh prefixes of lneght 2^k at the k-th
step

 A(i, k) = subsequnce of A of length 2^k starting at pos i. The position of A(i, k) in the sortedd arary of A(j, k) is in P(k, i)

When pass from A(i, k) and A(i + 2^k, k) concatenataed => we now have a substring of length 2^k+1,i.e., we use the information P(k, i) and
P(k, i+ i^2k), if i+2^k exceed the bounds, we just fill it with $ char, and consider it less than any char

At a certain step k there may be serverl substring A(i, k) = A(j, k), and these must be labeld idetinally, i.e., P(k, i) = P(k, j)!

Consider the construction of 

bobocel

Step 0: just sort each letter by order

0404123 

Step 1: oc < ob, so it becomes

0405123

step 2: length = 4
bobo
boce
cel$
l$$$
oboc
ocel

Total run time O(n * logn^2)


LCP
----------
Given two suffixes of a string A, compute their longest common prefix.

one can iterate descending from the biggest k down to 0 and check whether A(i, k) = A(j, k). If the two prefixes are equal, a common prefix
of lenght 2^k had been foudn. so we inclurease i and j by 2^k again and check if there are any more common prefixes

Note that lcp(x, y) = min{lcp(x, x+1), lcp(x+1, x+2), .... lcp(y-1, y)}


