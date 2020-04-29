#include<stdio.h>
#include<stdlib.h>

void rellena(int A[]);
void ordena(int A[]);
void imprime(int A[]);

int main(){
	int A[50];
	
	rellena(A);
	imprime(A);
	ordena(A);
	imprime(A);
	
	exit(0);
}

void rellena(int A[]){
	int i;
	for(i=0;i<50;i++){
		A[i]=rand()%52+1;
	}
}

void ordena(int A[]){	//bubble sort
	int i, j;
	int aux;
	
	for(i=0;i<50;i++){
		for(j=0;j<50-i;j++){
			if(A[j]>A[j+1]){
				aux=A[j];
				A[j]=A[j+1];
				A[j+1]=aux;	
			}
		}
	}
}

void imprime(int A[]){
	int i;
	
	for(i=0;i<50;i++){
		printf("%d ", A[i]);
	}
	printf("\n");
}
