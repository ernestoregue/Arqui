# Práctica 6 : Archivo de Registros
A medida que fuimos avanzando, ahora estamos programando el Archivo de Registros en vhdl.
Fue una simple simulación, tuvimos que hacerlo modularmente y con una descripción primitiva,
empezamos con un registro, la carga, la lectura y la retención, pero al igual que en la ALU
este es modular y debe estar conectado con otros elementos como el Barrel Shifter que ayuda a
efectuar os corrimientos o el demultiplexor para elegir en que Registro se va a estar escribiendo.

+ Los archivos .vhd del código fuente son
  + [Registro Unitario](Reg.vhd) Es el registro unitario, que puede guardar una cadena de 16 bits (Tam. ALU).
  + [Barrel Shifter](BS.vhd) Es el modulo que permite los corrimientos.
  + [Demultiplexor](Reg.vhd) Elemento que permite elegir donde se escribe la entrada.
  + [Registros](Regs.vhd) Es el registro completo, uniendo todo para el correcto funcionamiento.
+ Los archivos empezados en 'B' son los TestBench y en el último esta la simulación del archivo completo.

Para esta práctica no se realizó la prueba en tarjeta. En cambio se recurrio al uso de archivos para almacenar los resultados
+ Para las [Instrucciones](INSTRUCCIONES.txt) se lee la linea completa, el programa la interpreta y escribe
en un archivo de [Resultados](RESULTADO.TXT)
