#include <iostream>
#include <sstream>
#include <stdio.h>
#include <math.h>
#include <algorithm>
#include <vector>
#include <iomanip>
#include <map>
using namespace std;

#define MaxSize 30000;
int parent[MaxSize];

int Find(int a) {
  //assumption: parent[a] is set a itself on init
	if (parent[a] != a)
		parent[a] = Find(parent[a]);

	return parent[a];
}

void Union(int a, int b) {

	int aP = Find(a);
	int bP = Find(b);

	if (aP == bP)
		return;

	parent[max(aP, bP)] = min(aP, bP);
}
