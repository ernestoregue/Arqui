library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity T_B is end T_B;

architecture TB of T_B is
component Busqueda is
	Port(
		CLK,CLR,UP,DW,WPC : in STD_LOGIC;
		PCin : in STD_LOGIC_VECTOR(9 downto 0);
		SPout : inout STD_LOGIC_VECTOR(2 downto 0);
		PCout : out STD_LOGIC_VECTOR(24 downto 0);
		PCS : inout STD_LOGIC_VECTOR(9 downto 0)
	);
end component;
signal CLK,CLR,UP,DW,WPC : STD_LOGIC;
signal PCin : STD_LOGIC_VECTOR(9 downto 0);
signal PCout : STD_LOGIC_VECTOR(24 downto 0);
signal SPout : STD_LOGIC_VECTOR(2 downto 0);
signal PCS : STD_LOGIC_VECTOR(9 downto 0);

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
    Search : Busqueda Port map(
		CLK   => CLK, 
		CLR   => CLR,
		UP    => UP,
		DW    => DW,
		WPC   => WPC,
		PCin  => PCin,
		SPout => SPout,
		PCout => PCout,
		PCS => PCS
	);
	
	clk_process :process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    process
    file SALIDAS : TEXT;
        variable LINEA_R : line;
        variable V_PCo : STD_LOGIC_VECTOR(24 downto 0);
        variable V_SP : STD_LOGIC_VECTOR(2 downto 0);
        variable V_PCS : STD_LOGIC_VECTOR(15 downto 0);
        variable NO: integer;
        variable TR: integer;
        variable Rd : integer;
        variable Rt : integer;
        variable Rs : integer;
        variable BS : integer;
    
    file ENTRADAS : TEXT;
        variable LINEA_E : line;
        variable V_PCi : STD_LOGIC_VECTOR(15 downto 0);
        variable V_CLR : STD_LOGIC;
        variable V_WPC : STD_LOGIC;
        variable V_UP : STD_LOGIC;
        variable V_DW : STD_LOGIC;
        
    variable CADENA : STRING(1 to 5);
    
    variable j : integer;
	
	begin 
        file_open(ENTRADAS, "C:\Users\ernes\Desktop\Arq\P11_Proyecto_Vivado\ESTIMULOS.txt", READ_MODE);
        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P11_Proyecto_Vivado\RESULTADO.txt", WRITE_MODE);
        
        CADENA := "SP   ";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "PC   ";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "OPC  ";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "19-16";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "15-12";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "11-8 ";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "7-4  ";
        write(LINEA_R, CADENA, LEFT,6);
        
        CADENA := "3-0  ";
        write(LINEA_R, CADENA, LEFT,6);
        
        writeline(SALIDAS, LINEA_R);
	    
	    for i in 0 to 24 loop
            readline(ENTRADAS, LINEA_E);
            
            --PCIN
            Hread(LINEA_E, V_PCi);
            PCin <= V_PCi;
            --CLR
            read(LINEA_E, V_CLR);
            CLR <= V_CLR;
            --WPC
            read(LINEA_E, V_WPC);
            WPC <= V_WPC;
            --UP
            read(LINEA_E, V_UP);
            UP <= V_UP;
            --DW
            read(LINEA_E, V_DW);
            DW <= V_DW;
            
            wait until rising_edge(CLK);
            
            V_PCo := PCout;
            V_SP  := SPout;
            V_PCS := PCS;
            j := conv_integer(unsigned(SPout));
            
            write(LINEA_R, j, left, 6);
            write(LINEA_R, conv_integer(unsigned(PCS)), left, 6);
            write(LINEA_R, V_PCo(24 downto 20), left, 6);
            write(LINEA_R, V_PCo(19 downto 16), left, 6);
            write(LINEA_R, V_PCo(15 downto 12), left, 6);
            write(LINEA_R, V_PCo(11 downto 8), left, 6);
            write(LINEA_R, V_PCo(7 downto 4), left, 6);
            write(LINEA_R, V_PCo(3 downto 0), left, 6);
            
            NO := conv_integer(unsigned(V_PCo(24 downto 20)));
            IF NO = 0 then
                --Tipo R
                TR := conv_integer(unsigned(V_PCo(3 downto 0)));
                write(LINEA_R,RCODE(TR),left,6);
                --RD
                Rd := conv_integer(unsigned(V_PCo(19 downto 16)));
                write(LINEA_R,NUMREG(Rd),left,4);
                --RT
                Rt := conv_integer(unsigned(V_PCo(15 downto 12)));
                write(LINEA_R,NUMREG(Rt),left,4);
                --Si son de Corrimiento
                BS := conv_integer(unsigned(V_PCo(3 downto 0)));
                IF  BS >= 9 then
                    write(LINEA_R,V_PCo(7 downto 4),left,11);
                ELSE --No son de Corrimiento
                    Rs := conv_integer(unsigned(V_PCo(11 downto 8)));
                    write(LINEA_R,NUMREG(Rs),left,11);
                END IF;
            ELSIF NO>= 1 AND NO <= 3 then
                --Operaci?n
                write(LINEA_R,OPCODE(NO),left,6);
                --RD
                Rd := conv_integer(unsigned(V_PCo(19 downto 16)));
                write(LINEA_R,NUMREG(Rd),left,4);
                --lit
                IF NO = 1 THEN
                    write(LINEA_R,conv_integer(signed(V_PCo(15 downto 0))),left,15);
                ELSE
                    write(LINEA_R,conv_integer(unsigned(V_PCo(15 downto 0))),left,15);
                END IF;
            ELSIF NO >= 19 AND NO <= 20 then
                --Operaci?n
                write(LINEA_R,OPCODE(NO),left,6);
                --lit
                write(LINEA_R,conv_integer(unsigned(V_PCo(15 downto 0))),left,19);
            ELSIF NO >= 21 AND NO <= 22 then
                --Operaci?n
                write(LINEA_R,OPCODE(NO),left,25);
            ELSE
                --Operaci?n
                write(LINEA_R,OPCODE(NO),left,6);
                --RD
                Rd := conv_integer(unsigned(V_PCo(19 downto 16)));
                write(LINEA_R,NUMREG(Rd),left,4);
                --RT
                Rt := conv_integer(unsigned(V_PCo(15 downto 12)));
                write(LINEA_R,NUMREG(Rt),left,4);
                --lit
                IF NO = 4 OR (NO >= 7 AND NO <= 12) OR NO = 23 THEN
                    write(LINEA_R,conv_integer(unsigned(V_PCo(11 downto 0))),left,11);
                ELSE
                    write(LINEA_R,conv_integer(signed(V_PCo(11 downto 0))),left,11);
                END IF;
            END IF;
 
            WAIT FOR 1 ns;
            
            writeline(SALIDAS, LINEA_R);
        end loop;
        file_close(ENTRADAS);
        file_close(SALIDAS);
        wait;
    end process;
end TB;
