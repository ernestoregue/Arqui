library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity BRegs is
--  Port ( );
end BRegs;

architecture TB of BRegs is

component Regs is
    Port ( writeData : in STD_LOGIC_VECTOR (15 downto 0);
           writeReg  : in STD_LOGIC_VECTOR (3 downto 0);
           readData1 : inout STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0);
           readReg1, readReg2 :in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           CLK, CLR, SHE, WR, DIR : in STD_LOGIC);
end component;

--IN,S
signal wD   : STD_LOGIC_VECTOR (15 downto 0);
signal wR   : STD_LOGIC_VECTOR (3 downto 0);
signal rR1  : STD_LOGIC_VECTOR (3 downto 0);
signal rR2  : STD_LOGIC_VECTOR (3 downto 0);
signal S    : STD_LOGIC_VECTOR (3 downto 0);
signal CLK, CLR, SHE, RW, DIR : STD_LOGIC;

--OUT
signal rD2  : STD_LOGIC_VECTOR (15 downto 0);

--INOUT,S
signal rD1  : STD_LOGIC_VECTOR (15 downto 0);


begin

--RELOJ
reloj : process
        begin
            CLK <= '0';
            wait for 5 ns;
            CLK <= '1';
            wait for 5 ns;
        end process;

--ARCHIVO DE REGISTROS
Arch_REG : Regs
           Port map(
               writeData    => wD,
               writeReg     => wR,
               readData1    => rD1,
               readData2    => rD2,
               readReg1     => rR1, 
               readReg2     => rR2,
               shamt        => S,
               CLR          => CLR,
               SHE          => SHE,
               WR           => RW,
               DIR          => DIR,
               CLK          => CLK
               );

PRUEBAS : process
        -- lINEAS Y ARCHIVOS REQUERIDOS PARA LAS SALIDAS
        file SALIDAS    : TEXT;																					
	    variable LINEA_R : line;
	    variable VAR_RD1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	    variable VAR_RD2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	    
	    --LINEAS Y ARCHIVOS REQUERIDOS PARA LAS ENTRADAS
        file ENTRADAS   : TEXT;
        variable LINEA_E : line;
        variable VAR_CLR : STD_LOGIC;
        variable VAR_RR1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	    variable VAR_RR2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	    variable VAR_SHAMT : STD_LOGIC_VECTOR(3 DOWNTO 0);
	    variable VAR_WREG : STD_LOGIC_VECTOR(3 DOWNTO 0);
	    variable VAR_WD : STD_LOGIC_VECTOR(15 DOWNTO 0);
	    variable VAR_WR : STD_LOGIC;
	    variable VAR_SHE : STD_LOGIC;
	    variable VAR_DIR : STD_LOGIC;
        
        -- LA VARIABLE QUE VA LEER CADENAS
        variable CADENA : STRING(1 TO 5);
        
        begin
            file_open(ENTRADAS, "C:\Users\ernes\Desktop\Arq\P6_Proyecto_Vivado\INSTRUCCIONES.TXT", READ_MODE);
            file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P6_Proyecto_Vivado\RESULTADO.TXT", WRITE_MODE);
            
            
            CADENA := "RR1  ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "RR2  ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "SHAMT";
            write(LINEA_R, CADENA, left, 6);
            CADENA := "WREG ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "WD   ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "CLR  ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "WR   ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "SHE  ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "DIR  ";
            write(LINEA_R, CADENA, left, 1);
            CADENA := "RD1  ";
            write(LINEA_R, CADENA, left, 2);
            CADENA := "RD2  ";
            write(LINEA_R, CADENA, left, 2);
            
            writeline(SALIDAS,LINEA_R);
	       
	        wait for 100 ns;
	        
	        FOR i in 0 to 11 loop
	           --lee la linea completa
	           readline(ENTRADAS,LINEA_E);
	           --lee la linea 0 de rR1
	           hread(LINEA_E, VAR_RR1);
	           rR1<= VAR_RR1;
	           --lee la linea 0 de rR2
	           hread(LINEA_E, VAR_RR2);
	           rR2<= VAR_RR2;
	           --lee la linea 0 de shamt
	           hread(LINEA_E, VAR_SHAMT);
	           S<= VAR_SHAMT;
	           --lee la linea 0 de WREG
	           hread(LINEA_E, VAR_WREG);
	           wR<= VAR_WREG;
	           --lee la linea 0 de rR1
	           hread(LINEA_E, VAR_WD);
	           wD<= VAR_WD;
	           --lee la linea 0 de rR1
	           read(LINEA_E, VAR_CLR);
	           CLR<= VAR_CLR;
	           --lee la linea 0 de rR1
	           read(LINEA_E, VAR_WR);
	           RW<= VAR_WR;
	           --lee la linea 0 de rR1
	           read(LINEA_E, VAR_SHE);
	           SHE<= VAR_SHE;
	           --lee la linea 0 de rR1
	           read(LINEA_E, VAR_DIR);
	           DIR<= VAR_DIR;
	           
	           wait until rising_edge(CLK);
	           
	           VAR_RD1 := rD1;
	           VAR_RD2 := rD2;
	           
	           hwrite(LINEA_R, VAR_RR1, left, 5);
	           hwrite(LINEA_R, VAR_RR2, left, 5);
	           hwrite(LINEA_R, VAR_SHAMT, left, 6);
	           hwrite(LINEA_R, VAR_WREG, left, 5);
	           hwrite(LINEA_R, VAR_WD, left, 5);
	           write(LINEA_R, VAR_CLR, left, 5);
	           write(LINEA_R, VAR_WR, left, 5);
	           write(LINEA_R, VAR_SHE, left, 5);
	           write(LINEA_R, VAR_DIR, left, 5);
	           hwrite(LINEA_R, VAR_RD1, left, 5);
	           hwrite(LINEA_R, VAR_RD2, left, 5);
	           
	           writeline(SALIDAS, LINEA_R);
	        end loop;
	        file_close(ENTRADAS);
	        file_close(SALIDAS);
	      
	      WAIT;
        end process;       
end TB;
