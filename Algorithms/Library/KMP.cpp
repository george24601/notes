#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <algorithm>
using namespace std;

typedef unsigned long long L;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
#define Ep 1e-9

int const MaxSize = 100000;
char W[MaxSize];
int wLen;
int T[MaxSize];  //length of suffix that ends at previous char which is also a prefix of W
char S[MaxSize];
int sLen;

void BuildT() {
	T[0] = -1; //special case
	T[1] = 0; //0 because we have no suffix right now, which starts at index 1

	int i = 2;
	int prefixIToMatch = 0;

	while (i < wLen) { //i = wLen: longest suffix that is also a prefix

		if (W[i - 1] == W[prefixIToMatch]) {
			//i - 1 can extend an existing suffix which is also a prefix
			T[i] = prefixIToMatch + 1;
			i += 1;
			prefixIToMatch = prefixIToMatch + 1;
		} else if (prefixIToMatch > 0) {
			//so the suffix ending at i-1 will not work for current prefix index
			//notice that to reach this step, the suffix ending at i-2 already matches 0...prefixToIToMatch - 1
			//To try a shorter prefix, we use T[prefixIToMatch], which is the suffix ending at prefixToMatch -1, which is also a prefix
			//because suffix ending at i-2 matches 0...prefixToMatch -1 already, suffix ending at i -2 will match the new prefix
			prefixIToMatch = T[prefixIToMatch];
		} else {
			//prefixToMatch == 0 and doesn't match
			//i.e.,even first character doesn't match
			T[i] = 0;
			i += 1;
		}
	}
}

bool KMP()
{
	wLen = strlen(W);
	sLen = strlen(S);

	int mStart = 0; //current match's starting index in S
	int mLen = 0;//current match's len

	while(mStart + mLen < sLen) //no match found yet, more left in S to inspect
	{
		if(S[mStart + mLen] == W[mLen]) //current mStart is good
		{
			mLen++;
			if(mLen == wLen)
				return true; //matching found
		}else if (mLen == 0)//no matching whatsoever
		{
			mStart++;
		}else
		{
			//current mStart wont work, need to move it up, notice that T[mLen] chars are matched already ending at mLen - 1 in W
			//and mStart + mLen -1 in S
			//so we can move mStart to the start of this match
			mStart = mStart + mLen - T[mLen];
			mLen = T[mLen];
		}
	}

	return false;
}
