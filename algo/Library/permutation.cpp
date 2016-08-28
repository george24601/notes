using namespace std;

typedef unsigned long long UL;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
#define INF 2000000000
#define Ep 1e-8


vector<int> partial;
int const Seven = 7;
int used;

void gen() {
	if (partial.size() == Seven) {
                filter();
		return;
	}

	LP(i, 0, Seven)
	{
		if ((used >> i) & 1)
			continue;

		//cout << "used "<< used << " append " << i << endl;

		int prevState = used;

		used = used | (1 << i);

		partial.push_back(i);

		gen();

		partial.pop_back();

		//cout << "unappend " << i << endl;

		used = prevState;
	}
}
