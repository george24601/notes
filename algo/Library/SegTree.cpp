#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
const int MaxN = 100000;

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
