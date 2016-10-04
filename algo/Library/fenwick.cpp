#define LSB(i) ((i) & -(i))

int fenSum(int *a, int i) {
  int sum = 0.0;
  i++;
  while (i > 0) {
    sum += a[i - 1];
    i -= LSB(i);
  }
  return sum;
}

void fenAdd(int *a, int size, int delta, int i) {
  i++;
  size++;
  while (i < size) {
    a[i - 1] += delta;
    i += LSB(i);
  }
}

int fenGet(int *a, int i) {
  return fenSum(a, i) - fenSum(a, i - 1);
}

void fenSet(int *a, int size, int value, int i) {
  fenAdd(a, size, value - fenGet(a, i), i);
}
