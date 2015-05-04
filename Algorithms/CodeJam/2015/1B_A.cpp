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

int const MaxSize = 20;

L rev(L num) {
	L result = 0;

	while (num > 0) {
		result *= 10;
		result += (num % 10);

		num /= 10;
	}

	return result;
}

int calcLen(L num) {
	int len = 0;
	while (num > 0) {
		len++;
		num /= 10;
	}

	return len;
}

L inner_r(int num, int numLen, int tI) {
	if (tI == numLen - 1)
		return 0; //base case

	int tailBase = pow(10, tI);

	int digit = (num / tailBase) % 10;

	if (digit > 0) {
		if (tI >= (numLen + 1) / 2) {
			return 1 + inner_r(rev(num), numLen, numLen - tI - 1);

		} else {
			L ops = digit * tailBase;
			return ops + inner_r(num - ops, numLen, tI + 1);
		}
	} else {
		return inner_r(num, numLen, tI + 1);
	}
}

L outer_r(L num) {
	if (num <= 10) //base case
		return num;

	int lastDigit = num % 10;

	if (lastDigit == 0)
		return 1 + outer_r(num - 1);

	if (lastDigit > 1) {
		int ops = lastDigit - 1;
		return ops + outer_r(num - ops);
	}

	//now last digit is 1
	L rN = rev(num);

	int firstDigit = rN % 10;

	if (firstDigit > 1)
		return 1 + outer_r(rN);

	//now first last digit are 1, time to process inner

	int numLen = calcLen(num);
	L ops = inner_r(num, numLen, 1);

	//now of form 10*1, form 9*
	return 2 + ops + outer_r(pow(10, numLen - 1) - 1);
	//return 2 + ops + outer_r(num - 2);
}

int main(int argc, const char * argv[]) {

	//freopen("C:\\Test\\test.txt", "r", stdin);
	freopen("C:\\Test\\A-small-attempt1.in", "r", stdin);
	freopen("C:\\Test\\Asmall1.out", "w", stdout);

	int T = 0;
	scanf("%d", &T);

	L num;

	LPE(cn, 1, T)
	{
		scanf("%lld", &num);

		L result = outer_r(num);

		printf("Case #%d: %lld\n", cn, result);
	}

	return 0;
}
