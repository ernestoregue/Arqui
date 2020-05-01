library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TMD is

end TMD;

architecture TB of TMD is

component MD is
        Port( 
            add :   in STD_LOGIC_VECTOR(10 downto 0);
            dataIn :in STD_LOGIC_VECTOR(15 downto 0);
            WD,CLK :in STD_LOGIC;
            dataOut:out STD_LOGIC_VECTOR(15 downto 0)
        );
end component;

signal add :    STD_LOGIC_VECTOR(10 downto 0);
signal dataIn : STD_LOGIC_VECTOR(15 downto 0);
signal WD,CLK : STD_LOGIC;
signal dataOut: STD_LOGIC_VECTOR(15 downto 0);
        
begin

Clock: process
begin
    CLK <= '0';
    wait for 5 ns;
    CLK <= '1';
    wait for 5 ns;

end process;

MemoryData : MD
    Port map(
        add => add,
        dataIn => dataIn,
        CLK => CLK,
        WD => WD,
        dataOut => dataOut
        );

Simulacion : process
    
    --Lineas y archivos requeridos para las salidas
    file SALIDAS    :TEXT;
    variable LINEA_R:line;
    variable VAR_DO :STD_LOGIC_VECTOR(15 downto 0);
    
    --Lineas y archivos requeridos para las entradas
    
    file ENTRADAS   :TEXT;
    variable LINEA_E:line;
    variable VAR_ADD:STD_LOGIC_VECTOR(10 downto 0);
    variable VAR_DI :STD_LOGIC_VECTOR(15 downto 0);
    variable VAR_WD :STD_LOGIC;
    
    --Lector de cadenas
    variable CADENA : STRING(1 to 7);
    
    begin
        file_open(ENTRADAS, "C:\Users\ernes\Desktop\Arq\P7_Proyecto_Vivado\INSTRUCCIONES.TXT", READ_MODE);
        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P7_Proyecto_Vivado\RESULTADO.TXT", WRITE_MODE);
        
        CADENA := "ADD    ";
        write(LINEA_R, CADENA, left, 1);
        CADENA := "WD     ";
        write(LINEA_R, CADENA, left, 1);
        CADENA := "DATAIN ";
        write(LINEA_R, CADENA, left, 1);
        CADENA := "DATAOUT";
        write(LINEA_R, CADENA, left, 1);
        
        writeline(SALIDAS, LINEA_R);
        
        FOR i in 0 to 11 loop
	           --lee la linea completa
	           readline(ENTRADAS,LINEA_E);
	           
	           hread(LINEA_E, VAR_ADD);
	           add<= VAR_ADD;
	        
	           read(LINEA_E, VAR_WD);
	           WD<= VAR_WD;
	     
	           hread(LINEA_E, VAR_DI);
	           dataIn<= VAR_DI;
	           
	           wait until rising_edge(CLK);
	           
	           VAR_DO := dataOut;
	           
	           hwrite(LINEA_R, VAR_ADD, left, 7);
	           write(LINEA_R, VAR_WD, left, 7);
	           hwrite(LINEA_R, VAR_DI, left, 7);
	           hwrite(LINEA_R, VAR_DO, left, 7);
	           
	           writeline(SALIDAS, LINEA_R);
	           
	           wait until falling_edge(CLK);
        end loop;
	    file_close(ENTRADAS);
	    file_close(SALIDAS);
	    wait;
	end process;
end TB;
