#include <iostream>
#include <time.h>
#include <cstdlib>

using namespace std;


class Pila{
	private:
		unsigned short PCin;
		bool UP,DW,WPC,CLR;
				
		short PCout;
		unsigned int SPout : 3;
		
		unsigned int contadores[8];
		unsigned int Apuntador : 3;
	public:
		void set();
		void get();
		void operacion(unsigned short PCin, bool CLR, bool WPC, bool UP, bool DW);
		void operacion();

};

void Pila::set(){
	srand(time(NULL));
	
	for(short i = 0;i<8;i++)
		contadores[i] = rand() % 32768;

	Apuntador = rand() % 7;
}

void Pila::get(){
	cout<<endl;
	for(short i=0;i<8;i++){
		cout<<"PILA("<<i<<") = "<<contadores[i]<<'\t';
	}
	cout<<"\nApuntador: "<<Apuntador<<endl;
}

void Pila::operacion(unsigned short _PCin, bool _CLR, bool _WPC, bool _UP, bool _DW){
	PCin	= _PCin;
	UP		= _UP;
	DW		= _DW;
	WPC		= _WPC;
	CLR		= _CLR;
	
			
	if(CLR == true){
		Apuntador = 0;
		for(short i = 0;i<8;i++)
			contadores[i] = 0;	
	}else{
		if(WPC == false and UP == false and DW == false){
			Apuntador = Apuntador;
			contadores[Apuntador]++;
		}else if(WPC == true and UP == false and DW == false){
			Apuntador = Apuntador;
			contadores[Apuntador] = PCin;
		}else if(WPC == true and UP == true and DW == false){
			Apuntador++;
			contadores[Apuntador] = PCin;
		}else if(WPC == false and UP == false and DW == true){
			Apuntador--;
			contadores[Apuntador]++;
		}else if(WPC == false and UP == true and DW == false){
			cout<<"Error : CALL BEGINS IN UNKNOWN LINE"<<endl;
		}else if(WPC == true and UP == false and DW == true){
			cout<<"Exception : RET INSTRUCTION CANNOT WRITE PROGRAM COUNTER"<<endl;
		}else{
			cout<<"Error : STACK POINTER UP/DOWN SIMULTANEOUSLY"<<endl;
		}
	}
}

void Pila::operacion(){
	SPout = Apuntador;
	PCout = contadores[SPout];
	cout<<"PILA("<<SPout<<") = "<<PCout<<endl;	
}

int main(){
	Pila Obj;
	
//	Obj.set();					  RAND FILLED
	Obj.operacion(0,1,0,0,0); 	//RESET
	Obj.operacion(0,0,0,0,0); 	//LI R6,#87
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//LI R8,#90
	Obj.operacion();
	Obj.operacion(34,0,1,0,0); 	//B 34
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//ADD R8,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//SUB R1,R2,R3
	Obj.operacion();
	Obj.operacion(0x61,0,1,1,0);//CALL 0x61
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//LI R6,#87
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//LI R8,#90
	Obj.operacion();
	Obj.operacion(100,0,1,1,0); //CALL 100
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//ADD R8,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//SUB R1,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//LI R6,#87
	Obj.operacion();
	Obj.operacion(0,0,0,0,1);	//RET
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//SUB R1,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//LI R6,#87
	Obj.operacion();
	Obj.operacion(0,0,0,0,1);	//RET
	Obj.operacion();
	Obj.operacion(300,0,1,0,0);	//B 300
	Obj.operacion();
	Obj.operacion(889,0,1,1,0);	//CALL 889
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//ADD R8,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0);	//SUB R1,R2,R3
	Obj.operacion();
	Obj.operacion(0,0,0,0,0); 	//LI R6,#87
	Obj.operacion();
	Obj.operacion(0,0,0,0,1);	//RET
	Obj.operacion();
	Obj.operacion(0,0,0,0,1);	//RET
	Obj.operacion();
	Obj.get();
	
	//PRUEBA ADICIONAL
	Obj.operacion(0,0,0,1,0);	//RET
	Obj.operacion(0,0,0,1,1);	//RET
	Obj.operacion(0,0,1,0,1);	//RET
	Obj.operacion(0,0,1,1,1);	//RET
}
