int const MaxSize = 100010;

int fenw[MaxSize];
int n;

void addDelta(int x, int v) {
	while (x <= n) {
		fenw[x] += v;
		x = (x | (x - 1)) + 1;
	}
}

int preSum(int x) {
	int v = 0;
	while (x > 0) {
		v += fenw[x];
		x &= x - 1;
	}
	return v;
}
