library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity TMP is end TMP;

architecture TB of TMP is

component MP is
    Port(DIR : in STD_LOGIC_VECTOR(9 downto 0);
         ITT : out STD_LOGIC_VECTOR(24 downto 0)
        );
end component;

signal NI :  STD_LOGIC_VECTOR (9 downto 0) :="1111111111";
signal INST : STD_LOGIC_VECTOR (24 downto 0);

TYPE CO IS ARRAY (0 TO 23) OF STRING(1 TO 5);
CONSTANT OPCODE : CO := ("ADD  ","LI   ","LWI  ","SWI  ","SW   ","ADDI ","SUBI ","ANDI ",
                         "ORI  ","XORI ","NANDI","NORI ","XNORI","BEQI ","BNEI ","BLTI ",
                         "BLETI","BGTI ","BGETI","B    ","CALL ","RET  ","NOP  ","LW   "
                        );
                                             
TYPE COR IS ARRAY (0 TO 10) OF STRING(1 TO 5);
CONSTANT RCODE : COR := ("ADD  ","SUB  ","AND  ","OR   ","XOR  ",
                         "NAND ","NOR  ","XNOR ","NOT  ","SLL  ","SRL  "
                        );
                    
TYPE REG IS ARRAY (0 TO 15) OF STRING(1 TO 3);
CONSTANT NUMREG : REG := ("R0 ","R1 ","R2 ","R3 ","R4 ","R5 ","R6 ","R7 ","R8 ","R9 ","R10","R11","R12","R13","R14","R15");


begin

    PC : MP
        Port map(
        DIR=> NI,
        ITT=> INST
        );
    

    process
        file SALIDAS : TEXT;																					
        variable LINEA : line;
        variable NO: integer;
        variable TR: integer;
        variable Rd : integer;
        variable Rt : integer;
        variable Rs : integer;
        variable BS : integer;
        variable F : STRING(1 TO 54) := "INICIO,no se puede inicializar la DIR con el valor 0  ";
        
        begin
        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P8_Proyecto_Vivado\RESULTADO.TXT", WRITE_MODE);
        write(LINEA,F,left,4);
        WHILE true LOOP
            write(LINEA,conv_integer(unsigned(NI)),left,4);
            NO := conv_integer(unsigned(INST(24 downto 20)));
            IF NO = 0 then
                --Tipo R
                TR := conv_integer(unsigned(INST(3 downto 0)));
                write(LINEA,RCODE(TR),left,6);
                --RD
                Rd := conv_integer(unsigned(INST(19 downto 16)));
                write(LINEA,NUMREG(Rd),left,4);
                --RT
                Rt := conv_integer(unsigned(INST(15 downto 12)));
                write(LINEA,NUMREG(Rt),left,4);
                --Si son de Corrimiento
                BS := conv_integer(unsigned(INST(3 downto 0)));
                IF  BS >= 9 then
                    write(LINEA,INST(7 downto 4),left,11);
                ELSE --No son de Corrimiento
                    Rs := conv_integer(unsigned(INST(11 downto 8)));
                    write(LINEA,NUMREG(Rs),left,11);
                END IF;
            ELSIF NO>= 1 AND NO <= 3 then
                --Operación
                write(LINEA,OPCODE(NO),left,6);
                --RD
                Rd := conv_integer(unsigned(INST(19 downto 16)));
                write(LINEA,NUMREG(Rd),left,4);
                --lit
                IF NO = 1 THEN
                    write(LINEA,conv_integer(signed(INST(15 downto 0))),left,15);
                ELSE
                    write(LINEA,conv_integer(unsigned(INST(15 downto 0))),left,15);
                END IF;
            ELSIF NO >= 19 AND NO <= 20 then
                --Operación
                write(LINEA,OPCODE(NO),left,6);
                --lit
                write(LINEA,conv_integer(unsigned(INST(15 downto 0))),left,19);
            ELSIF NO >= 21 AND NO <= 22 then
                --Operación
                write(LINEA,OPCODE(NO),left,25);
            ELSE
                --Operación
                write(LINEA,OPCODE(NO),left,6);
                --RD
                Rd := conv_integer(unsigned(INST(19 downto 16)));
                write(LINEA,NUMREG(Rd),left,4);
                --RT
                Rt := conv_integer(unsigned(INST(15 downto 12)));
                write(LINEA,NUMREG(Rt),left,4);
                --lit
                IF NO = 4 OR (NO >= 7 AND NO <= 12) OR NO = 23 THEN
                    write(LINEA,conv_integer(unsigned(INST(11 downto 0))),left,11);
                ELSE
                    write(LINEA,conv_integer(signed(INST(11 downto 0))),left,11);
                END IF;
            END IF;
            write(LINEA,INST(24 downto 20),left,6);
            write(LINEA,INST(19 downto 16),left,5);
            write(LINEA,INST(15 downto 12),left,5);
            write(LINEA,INST(11 downto 8),left,5);
            write(LINEA,INST(7 downto 4),left,5);
            write(LINEA,INST(3 downto 0),left,5);
            writeline(SALIDAS,LINEA);
            NI<=NI+1;
            WAIT FOR 1 ns;
            
        END LOOP;
        
        file_close(SALIDAS); 
    end process;
        
end TB;
