#include <stdio.h>

int somaidades(int[]);

int somaidades(int idades[]){
	int soma=0;
	while(1){
		if((*idades)==NULL)
			break;
		soma+=*idades;
		idades++;
	}
	return soma*5;
}

int main(){
	int idades[]={21,52,34,40,15,60,3,NULL};
	printf("%d",somaidades(idades));
}
