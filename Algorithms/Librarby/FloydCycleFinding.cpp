#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
#include <algorithm>
#include <vector>
#include <iomanip>
#include <set>
#include <map>
#include <stack>
#include <queue>
#include <cmath>
using namespace std;

typedef unsigned long long L;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
#define Min(a ,b ) a < b ? a : b
#define Max(a ,b ) a > b ? a : b
typedef pair<int, int> DW;
typedef vector<vector<DW> > WAL;
typedef vector<vector<int> > SAL;
typedef pair<int, int> PII;
#define Ep 1e-9

const int MaxSize = 1000;

int cycleStart;
int cycleLength;

void ComputeCycle() {

	PII init = make_pair(a % mod, b % mod);

	PII t = f(init);
	PII h = f(f(init));

	while (true) {
		if (t == h)
			break;

		t = f(t);
		h = f(f(h));
	}

	int startIndex = 0;
	t = init;

	while (true) {
		if (t == h)
			break;

		t = f(t);
		h = f(h);
		startIndex++;
	}

	t = f(t);
	int numItems = 1;

	while (true) {
		if (t == h)
			break;

		t = f(t);
		numItems++;
	}

	cycleStart = startIndex;
	cycleLength = numItems;
}

