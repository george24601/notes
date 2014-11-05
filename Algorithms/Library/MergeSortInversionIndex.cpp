#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
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
using namespace std;

typedef unsigned long long L;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
#define Ep 1e-8

const int INF = 2147483640;

const int MaxSize = 10000000;

//merge sort + inversion index

int nums[MaxSize];
int target[MaxSize];

L Merge(int start, int midIndex, int end) {
	L totalOp = 0;

	int leftSize = midIndex - start + 1;
	int rightSize = end - midIndex;

	int currentIndex = start;
	int leftIndex = 0;
	int rightIndex = 0;

	while (leftIndex < leftSize || rightIndex < rightSize) {
		int actualLeftIndex = start + leftIndex;
		int actualRightIndex = midIndex + 1 + rightIndex;

		int leftNum = nums[actualLeftIndex];
		int rightNum = nums[actualRightIndex];

		if (leftIndex < leftSize && rightIndex < rightSize) {
			if (leftNum < rightNum) {
				target[currentIndex] = leftNum;

				if (actualLeftIndex > currentIndex)
					totalOp += actualLeftIndex - currentIndex;

				leftIndex++;

			} else if (leftNum > rightNum) {
				target[currentIndex] = rightNum;

				if (actualRightIndex > currentIndex)
					totalOp += actualRightIndex - currentIndex;

				rightIndex++;
			} else {
			}

		} else if (leftIndex < leftSize) {
			target[currentIndex] = leftNum;

			if (actualLeftIndex > currentIndex)
				totalOp += actualLeftIndex - currentIndex;

			leftIndex++;

		} else {
			target[currentIndex] = rightNum;

			if (actualRightIndex > currentIndex)
				totalOp += actualRightIndex - currentIndex;

			rightIndex++;
		}

		currentIndex++;
	}

	return totalOp;
}

L Process_r(int start, int end) {
	if (start >= end)
		return 0;

	int midIndex = start + ((end - start) / 2);

	L left = Process_r(start, midIndex);
	L right = Process_r(midIndex + 1, end);

	L mergeOps = Merge(start, midIndex, end);

	LPE(i, start, end)
		nums[i] = target[i];

	return left + right + mergeOps;
}
