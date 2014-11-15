#include <iostream>
#include <sstream>
#include <stdio.h>
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
#include <string>
using namespace std;

typedef long long L;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
#define Ep 1e-8

const int INF = 2147483640;

const int MaxN = 100000;

int q, n;
int nums[MaxN];


class SegTree {
private:
	int start;
	int end;

	SegTree() {
		start = -1;
		end = -1;
		left = NULL;
		right = NULL;
	}

public:
	SegTree* left;
	SegTree* right;

	PII le;
	PII re;
	PII me;

	SegTree(int s, int e, SegTree* l, SegTree* r, PII lec, PII rec, PII mec) {
		start = s;
		end = e;
		left = l;
		right = r;

		le = lec;
		re = rec;
		me = mec;
	}

	~SegTree() {
		delete left;
		delete right;
	}

	PII Q(int s, int e) {

		//Assumption s >= start, e <= end;

		if(s == start && e == end)
			return me;

		if(left != NULL && right != NULL)
		{
			if(s >= right->start)
				return right->Q(s, e);

			if(e <= left-> end)
				return left->Q(s, e);

			int mid = (start + end)/2;
			PII leftQ = left -> Q(s, mid);
			PII rightQ = right ->Q(mid + 1, e);

			PII toReturn = leftQ.second > rightQ.second? leftQ: rightQ;

			if(nums[mid] == nums[mid + 1])
			{
				int mlc = min(mid - s + 1, left->re.second); //need to process counts
				int mrc = min(e - mid, right->le.second);//need to process counts;

				if(toReturn.second < mlc + mrc)
					toReturn = PII (nums[mid], mlc + mrc);
			}

			return toReturn;

		}else if(left != NULL)
		{
			return left->Q(s, e);
		}
		else
		{
			return right->Q(s, e);
		}

		//if s == start && e == end => directly return this seg's conclusion
		//if s < right->start, get left q //NULL case
		//left candidate: leftQ, left's RC
		//similarly if e > left -> end, get right Q
		//right candidate: rightQ, right's LC
		//merge: leftQ, right Q, left's RC + right's LC if possible

		//return of winner and frequence

	}

};

SegTree* BuildTree(int start, int end) {
	if (start == end) {
		PII single = PII (nums[start], 1);
		return new SegTree(start, end, NULL, NULL, single, single, single);
	}

	int mid = (start + end) / 2;

	SegTree* l = BuildTree(start, mid);

	SegTree* r = BuildTree(mid + 1, end);

	int	 newLc = l->le.second;
	int	 newRc = r->re.second;

	PII newM = l->me.second > r->me.second? l->me : r-> me;

	//calc new left
	if(nums[mid] == nums[mid + 1])
	{
		int newMidc = l->re.second + r-> le.second;

		if(nums[start] == nums[mid + 1])
			newLc += r->le.second;

		if(nums[mid] == nums[end])
			newRc += l->re.second;

		if(newMidc > newM.second)
			newM = PII (nums[mid], newMidc);
	}

	//merge val here
	return new SegTree(start, end, l, r, PII(nums[start], newLc),PII(nums[end], newRc), newM);

}
