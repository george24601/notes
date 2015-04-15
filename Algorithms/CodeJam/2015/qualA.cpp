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
int sMax;
char digits[MaxSize];

int main(int argc, const char * argv[]) {

	//freopen("C:\\Test\\test.in", "r", stdin);
	freopen("C:\\Test\\A-small-attempt1.in", "r", stdin);
	freopen("C:\\Test\\small1.txt", "w", stdout);

	scanf("%d", &T);

	LPE(cn, 1, T){//case 1 to T
		scanf("%d %s", &sMax, digits);

		int sum = digits[0] - '0';
		int numF = 0;

		LPE(i, 1, sMax){//needs to be equal since size is max + 1{
			int curDigit = digits[i] - '0';

			if(curDigit == 0)
				continue;

			if (i > sum + numF)
				numF += (i - sum - numF);

			sum += curDigit;
		}


		printf("Case #%d: %d\n", cn, numF);
	}


	return 0;
}
