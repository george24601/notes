#define LP(i, a, b) for (int i = int(a); i < int(b); i++)
#define LPE(i, a, b) for (int i = int(a); i <= int(b); i++)

int const MaxN = 1000000;
bool prime[MaxN + 1];
void sieve(){

  memset(prime, true, sizeof(prime));

  LP(i, 2, MaxN){
    if(!prime[i])
      continue;

    int factor = 2;
    while(i * factor <= MaxN){
      prime[i* factor] = false;
      factor++;
    }
  }
}

