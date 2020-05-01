#include <iostream>
#include <time.h>
#include <cstdlib>
using namespace std;

class Reg{
	private:
		short writeData;
		unsigned short writeReg;
		unsigned short readReg1;
		unsigned short readReg2;
		unsigned short shamt;
		bool WR, SHE, DIR, CLR;
		
		short readData1;
		short readData2;
		
		short datos[16];
		
	public:
		void set();
		void get();
		void operacionSincrona(short _wD, unsigned short _wR, unsigned short _shamt, unsigned short _rR1, bool _WR, bool _SHE, bool _DIR, bool _CLR);
		void operacionAsincrona(bool _CLR);
		void operacionAsincrona(bool _CLR, unsigned short _rR1, unsigned short _rR2);
		
};

void Reg::set(){
	srand(time(NULL));
	
	for(short i = 0;i<16;i++){
		datos[i] = rand() % 32768;
	}
}

void Reg::get(){
	for(short i=0;i<16;i++){
		cout<<datos[i]<<'\t';
	}
	cout<<endl;
}

void Reg::operacionSincrona(short _wD, unsigned short _wR, unsigned short _shamt, unsigned short _rR1, bool _WR, bool _SHE, bool _DIR, bool _CLR){
	CLR 		= _CLR;
	writeData 	= _wD;
	writeReg	= _wR;
	shamt 		= _shamt;
	readReg1	= _rR1;
	WR 			= _WR;
	SHE 		= _SHE;
	DIR 		= _DIR;
	
			
	if(CLR == true){
		operacionAsincrona(true);
	}else{
		if(WR == false && SHE == false && DIR == false){
			for(short i=0;i<16;i++){
				datos[i]=datos[i];
			}
		}else if(WR == true && SHE == false){
			if(writeReg>15){
				cout<<"Exception : MAX_NUM_REG = 16"<<endl;
			}else{
				datos[writeReg] = writeData;
			}
		}else if(WR == true && SHE == true && DIR == false){
			if(writeReg>15){
				cout<<"Exception : MAX_NUM_REG = 16"<<endl;
			}else if(shamt>15){
				cout<<"Exception : MAX_SHAMT = 16"<<endl;
			}else{
				datos[writeReg] = datos[readReg1] >> shamt ;
			}
		}else if(WR == true && SHE == true && DIR == true ){
			if(writeReg>15){
				cout<<"Exception : MAX_NUM_REG = 16"<<endl;
			}else if(shamt>15){
				cout<<"Exception : MAX_SHAMT = 16"<<endl;
			}else{
			datos[writeReg] = datos[readReg1] << shamt ;
			}
		}else if(WR == false && SHE == false && DIR == true){
			cout<<"Exception : NO_SHIFT_ENABLED"<<endl;
		}else if(WR == false && SHE == true){
			cout<<"Exception : SHIFT_BUT_CANNOT_WRITE"<<endl;
		}else{
			cout<<"Exception : BAD_IMPLEMENTATION"<<endl;
		}
	
	}
}

void Reg::operacionAsincrona(bool _CLR){
	CLR = _CLR;
	if(CLR == true){
		for(short i=0;i<16;i++){
			datos[i]=0;
		}
	}
}

void Reg::operacionAsincrona(bool _CLR, unsigned short _rR1, unsigned short _rR2){
	CLR = _CLR;
	
	readReg1 = _rR1;
	readReg2 = _rR2;
	if(readReg1>15 || readReg2>15){
		cout<<"Exception : MAX_NUM_REG = 16"<<endl;
	}else{
		if(CLR == false){
			cout<<"Localidad "<<readReg1<<" es : "<<datos[readReg1]<<endl;
			cout<<"Localidad "<<readReg2<<" es : "<<datos[readReg2]<<endl;
		}else{
			operacionAsincrona(true);
			cout<<"Localidad " <<readReg1<<" es : "<<datos[readReg1]<<endl;
			cout<<"Localidad "<<readReg2<<" es : "<<datos[readReg2]<<endl;
		}
	}
}

int main() {

	Reg Obj;
	
	Obj.operacionAsincrona(true);										//CLR acivado
	Obj.operacionSincrona(89,1,0,0,true,false,false,false);				//datos[1] = 89
	Obj.operacionSincrona(72,2,0,0,true,false,false,false);				//datos[2] = 72
	Obj.operacionSincrona(123,3,0,0,true,false,false,false);			//datos[3] = 123
	Obj.operacionSincrona(53,4,0,0,true,false,false,false);				//datos[4] = 53
	
	Obj.operacionAsincrona(false, 1, 2);								//Lee datos[1] y datos[2]
	Obj.operacionAsincrona(false, 3, 4);								//Lee datos[3] y datos[4]
	
	Obj.operacionSincrona(0,2,3, 1, true, true, true, false);			//Corre 3 bits (izquierda) de la localidad 1 y lo guarda en la localidad 2				
	Obj.operacionSincrona(0,4,5, 3,true, true, false, false);			//Corre 5 bits (derecha) de la localidad 3 y lo guarda en la localidad 4
	
	
	Obj.operacionAsincrona(false, 1, 2);								//Se lee datos[1] y datos[2]
	Obj.operacionAsincrona(false, 3, 4);								//Se lee datos[3] y datos[4]
	
	Obj.get();															//Se muestran todos los datos
	Obj.operacionAsincrona(true);										//CLR acivado
}
