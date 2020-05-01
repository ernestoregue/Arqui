# Práctica 4 : ALU (Unidad Lógica-Aritmética)
La práctica consistía en programar en lenguaje vhdl la ALU para 1 bit además funciona modularmente, es decir, se usan ALUs de 1 bit en modo cascada y así formar la ALU de n bits. 

Operaciones | Sel A | Sel B | OpI | OpD
:---------- | :---: | :---: | :---: | :---:
AND | 0 | 0 | 0 | 0
OR | 0 | 0 | 0 | 1
XOR | 0 | 0 | 1 | 0
NAND | 1 | 1 | 0 | 1
NOR | 1 | 1 | 0 | 0
XNOR | 0 | 1 | 1 | 0
XNOR(2) | 1 | 0 | 1 | 0
NOT(NAND) a = b| 1 | 1 | 0 | 1
NOT(NOR) a = b| 1 | 1 | 0 | 0
SUMA Cin = 0 | 0 | 0 | 1 | 1 
RESTA Cin = 1 | 0 | 1 | 1 | 1 



