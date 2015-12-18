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

    //Node payload goes here

    SegTree(int s, int e, SegTree* l, SegTree* r) {
      start = s;
      end = e;
      left = l;
      right = r;

      //payload assignment here
    }

    ~SegTree() {
      delete left;
      delete right;
    }

    //Query here, note that the tree is binary,i.e., either two chilren or here

};

SegTree* BuildTree(int start, int end) {
  if (start == end) {
    return new SegTree(start, end, NULL, NULL);
  }

  int mid = (start + end) / 2;

  SegTree* l = BuildTree(start, mid);

  SegTree* r = BuildTree(mid + 1, end);

  //calculate combined payload here

  return new SegTree(start, end, l, r);

}
