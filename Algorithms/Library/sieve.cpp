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
using namespace std;

typedef unsigned long long UL;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
typedef pair<int, int> PII;
#define INF 2000000000
#define Ep 1e-9


int const MaxN = 1000000;
bool prime[MaxN + 1];


void sieve(){

  memset(prime, true, sizeof(prime));

  LP(i, 2, MaxN){
    if(!prime[i])
      continue;

    int factor = 2;
    while(i * factor <= MaxN){
      prime[i* factor] = false;
      factor++;
    }
  }
}

