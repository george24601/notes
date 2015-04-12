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

int const MaxSize = 1010;
int T;
int D;
int plates[MaxSize];
int curMax;

int sc[MaxSize][MaxSize];

int singleCost(int size, int longest) {
	if (sc[size][longest] >= 0)
		return sc[size][longest];

	if (size <= longest)
		return 0;

	int firstH = size / 2;
	int secondH = size - firstH;

	int ans = 1 + singleCost(firstH, longest) + singleCost(secondH, longest);

	sc[size][longest] = ans;

	return ans;
}

int Cost(int longest, int maxCost) {
	int totalCost = 0;

	LPE(i, longest + 1, curMax)
	{
		if (plates[i] == 0)
			continue;

		totalCost +=
				plates[i] * (i % longest == 0 ?
						(i / longest) - 1 : (i / longest));

		if (totalCost >= maxCost)
			return -1;
	}

	return totalCost;
}

int main(int argc, const char * argv[]) {

	//freopen("C:\\Test\\test.txt", "r", stdin);
	freopen("C:\\Test\\B-large.in", "r", stdin);
	freopen("C:\\Test\\B-large.out", "w", stdout);

	scanf("%d", &T);

	LP(i, 0, MaxSize)
		memset(sc[i], -1, sizeof(sc[i]));

	LPE(cn, 1, T)
	{ //case 1 to T
		memset(plates, 0, sizeof(plates));

		scanf("%d", &D);

		curMax = 0;

		LP(i, 0, D)
		{
			int num;
			scanf("%d", &num);
			plates[num]++;

			curMax = max(curMax, num);
		}

		int curTime = curMax;

		for (int longest = curMax - 1; longest >= 1; longest--) {
			int maxCost = curTime - longest;

			int cost = Cost(longest, maxCost);

			if (cost == -1)
				continue;

			curTime = cost + longest;
		}

		printf("Case #%d: %d\n", cn, curTime);

	}

	return 0;
}
