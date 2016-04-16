#include <vector>
#include <cmath>
using namespace std;

typedef unsigned long long L;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)
typedef pair<int, int> PII;
typedef vector<vector<PII> > WAL;
typedef vector<vector<int> > SAL;
#define Ep 1e-9
#define INF 2000000000

const int MaxSize = 100;

int n;
WAL adj;
int dist[MaxSize];
int prev[MaxSize];

void Process(int start) {

	LP(v, 0 , n)
		dist[v] = INF;

	dist[start] = 0;

	LPE(pathLeng, 1, n - 1)
	{
		LP(v, 0 , n)
		{
			if (dist[v] == INF) //not connected yet
				continue;

			LP(i, 0, adj[v].size()) //relax all outgoing edges
			{
				int u = adj[v][i].first;

				int uv = adj[v][i].second;
				int newDist = dist[v] + uv;

				if (newDist < dist[u]) {
					dist[u] = newDist;
					prev[u] = v;
				}
			}
		}
	}
}
