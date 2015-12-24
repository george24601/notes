#include <assert.h>
using namespace std;

typedef unsigned long long UL;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)

int const MaxN = 500000;

map<LL, int> valToID;

int tree[MaxN * 3];
int numLeaves;

//range on [l, r), notice right is NOT inclusive
LL get(int l, int r) {
	LL res = 0;

	for (l += numLeaves, r += numLeaves; l < r; l >>= 1, r >>= 1) {

		if (l & 1) {
			//left is a right child, need to include this one,
			//and ignore the current parent by going to the next leave node
			res += tree[l];
			l++;
			res %= MOD;
		}

		if (r & 1) {
			//right is right child,
			res += tree[--r]; //it is --r, because r is not inclusive
			res %= MOD;
		}
	}
	return res;
}

//p is value of a LEAF node in [0, numLeaves)
void update(int p, int value) {

	for (tree[p += numLeaves] = value; p > 1; p >>= 1){
		tree[p >> 1] = tree[p] + tree[p ^ 1]; //p^1 flips the last bit
		tree[p >> 1] %= MOD;
	}
}

void buildTree() {
	for (int i = numLeaves - 1; i > 0; --i)
		tree[i] = tree[2 * i] + tree[2 * i + 1];
}
