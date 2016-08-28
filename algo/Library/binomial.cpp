typedef unsigned long long UL;
typedef long long LL;
#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)

int const MaxSize = 40;

LL chooseN[MaxSize + 1][MaxSize];

void initChoose() {
	LPE(i, 0, MaxSize)
	{
		memset(chooseN[i], 0, sizeof(chooseN[i]));
		chooseN[i][0] = 1;
		chooseN[i][i] = 1;
	}
}

LL choose(int top, int bottom) {

	if (top < 0 || bottom < 0 || bottom > top)
		return 0;

	assert(top >= bottom);

	if (chooseN[top][bottom])
		return chooseN[top][bottom];

	return chooseN[top][bottom] = choose(top - 1, bottom - 1)
			+ choose(top - 1, bottom);
}
