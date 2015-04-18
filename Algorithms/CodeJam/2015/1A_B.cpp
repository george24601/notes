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
int M[MaxSize];
L N;
int B;

void p(L ans, L open) {

	L num = 0;
	LP(k,0, B)
	{
		if(ans % M[k] == 0)
		{
			num++;

			if(num == open)
			{
				printf("%d\n", k + 1);
				return;
			}
		}
	}
}

void b_r(L low, L high) {
	L mid = (low + high) / 2;

	L processedIng = 0;
	L open = 0;

	LP(k, 0, B)
	{
		L done = mid / M[k];

		processedIng += done;

		if (mid % M[k] == 0) {
			open++;
		} else {
			processedIng++;
		}
	}

	if ((processedIng + open) < N)
		b_r(mid + 1, high);
	else if ((processedIng + open) == N)
		if (open == 0)
			b_r(low, mid - 1);
		else
			p(mid, N - processedIng);
	else {
		if (processedIng >= N)
			b_r(low, mid - 1);
		else
			p(mid, N - processedIng);
	}
}

int main(int argc, const char * argv[]) {

	freopen("C:\\Test\\B-large.in", "r", stdin);
	//freopen("C:\\Test\\B-large.in", "r", stdin);
	freopen("C:\\Test\\large1.out", "w", stdout);

	int T;
	scanf("%d", &T);

	LPE(cn, 1, T)
	{
		int n1;
		scanf("%d %d", &B, &n1);
		N = n1;

		LP(i,0, B)
		{
			int curN;
			scanf("%d", &curN);
			M[i] = curN;
		}

		L maxTime = N;
		maxTime = maxTime * 100000;

		printf("Case #%d: ", cn);
		b_r(0, maxTime);
	}

	return 0;
}
