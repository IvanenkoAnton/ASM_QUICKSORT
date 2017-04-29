/*
	Created by Anton Ivanenko, January 2017
	ASM_QuickSort
*/
//main file, where testing speed of ASM and C++ realisations
//is located
#include <iostream>
#include <ctime>

#define N 100000 //size of vector

using namespace std;

void show_mas(int *,int);
extern "C" void QSortInt(int *, int, int);
void QSort(int *mas, int, int);

int main(){
	int mas[N], mas1[N];
	clock_t begtime, endtime;

	begtime = clock() / CLOCKS_PER_SEC;
	srand(time(NULL));
	for (int i = 0; i < N; i++) {
		mas[i] = rand() % N;
		mas1[i] = mas[i];
	}

	cout << "size: " << N << endl;


	begtime = clock() / CLOCKS_PER_SEC;
	QSortInt(mas, 0, N - 1);
	endtime = clock() / CLOCKS_PER_SEC;

	cout << "asm time: " << (float)(endtime - begtime) / CLOCKS_PER_SEC << " sec" << endl;

    begtime = clock()/ CLOCKS_PER_SEC;
	QSort(mas1, 0, N - 1);
	endtime = clock() / CLOCKS_PER_SEC;

	cout << "C++ time: " << (float)(endtime - begtime) / CLOCKS_PER_SEC << " sec" << endl;

	system("pause");

	return 0;
}

void QSort(int *mas, int left, int right) {
	int i = left, j = right;
	int tmp;
	int central = mas[(left + right) / 2];

	while (i <= j) {

		while (mas[i] < central) i++;
		while (mas[j] > central) j--;

		if (i <= j) {
			tmp = mas[i];
			mas[i] = mas[j];
			mas[j] = tmp;
			i++;
			j--;
		}
	}

	if (i < right) QSortInt(mas, i, right);
	if (j > left) QSortInt(mas, left, j);
}

void show_mas(int *mas, int size) {
	for (int i = 0; i < size; i++) {
		cout << mas[i] << " ";
	}
	cout << endl;
}

