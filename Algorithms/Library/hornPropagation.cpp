#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <algorithm>
#include <vector>
#include <iomanip>
#include <set>
#include <map>
#include <stack>
#include <queue>
#include <bitset>
using namespace std;

typedef unsigned long long UL;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
#define INF 2000000000
#define Ep 1e-9

/*
 an n^2 implemnetaion of unit propagation of horn clauses.

 It can be improved to O(n), by introducing a literal to clause map, and recursiving propagate based on the map, similar to cascading events
 
*/

//literal starts with 1
//clause starts with 0
int const MaxLit = 2020;
int const MaxClause = 2020;

bitset<MaxLit> ans; //all 1, turn to 0

int clausePs[MaxClause];
bitset<MaxLit> clauseNs[MaxClause]; //all 0s, turn to 1

int numLit, numClause; 

void reset() {
	memset(clausePs, 0, sizeof(clausePs));

	ans.reset();
	LPE(i, 1, numLit)
		ans.flip(i);

	LP(i, 0, numClause){
		clauseNs[i].reset();
	}
}

bool unitProp() {
	bool success = false;

	while (!success) {
		success = true;

		LP(clause, 0, numClause)
		{
			int posLit = clausePs[clause];
			bool posGood = posLit && !ans[posLit]; //1 in ans means it is FALSE
			bool negGood = (clauseNs[clause] & ans).any();

			//cout << clause << " "<< posLit << " " << posGood << " " << negGood << endl;

			if (posGood || negGood)
				continue;

			//both pos and neg are false, this means we are at form 1...10

			success = false;

			if (posLit) {
				ans.flip(posLit); //only choice is to flip 0
			} else {
				return false; //we can not flip anymore, as it will revert previous step!
			}
		}

	}

	return true;
}
