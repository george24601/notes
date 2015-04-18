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

typedef unsigned long long L;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
typedef pair<int, int> FT;
#define INF 2000000000
#define Ep 1e-9

int const MaxSize = 10010;
int num[MaxSize];
int N;

int main(int argc, const char * argv[]) {

	freopen("C:\\Test\\A-large.in", "r", stdin);
	//freopen("C:\\Test\\B-large.in", "r", stdin);
	freopen("C:\\Test\\large1.out", "w", stdout);

	int T;
	scanf("%d", &T);

	LPE(cn, 1, T)
	{
		scanf("%d", &N);

		LP(i,0, N)
		{
			int curN;
			scanf("%d", &curN);
			num[i] = curN;
		}

		int first = 0;
		int maxDelta = 0;

		LP(i, 1, N)
		{
			int cur = num[i];
			int prev = num[i - 1];

			if(cur < prev)
			{
				int diff = prev- cur;
				first += diff;
				maxDelta = max(maxDelta, diff);
			}
		}

		int second = 0;
		LP(i, 0, N - 1)
		{
			int cur = num[i];

			second += min (cur, maxDelta);
		}


		printf("Case #%d: %d %d\n", cn, first, second);
	}

	return 0;
}
