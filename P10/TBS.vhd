library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.std_logic_TEXTIO.ALL;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_UNSIGNED.ALL;
use IEEE.std_logic_ARITH.ALL;

entity TB_Pila is end TB_Pila;

architecture TB of TB_Pila is

component Pila is
    Port(
        PCin : in STD_LOGIC_VECTOR(15 downto 0);
        CLK,CLR,WPC,UP,DW : in STD_LOGIC;
        PCout : out STD_LOGIC_VECTOR(15 downto 0);
        SPout : inout STD_LOGIC_VECTOR(2 downto 0)
    );
end component;

signal CLK,CLR,UP,DW,WPC : std_logic := '0';
signal PCin : std_logic_vector(15 downto 0);

signal SPout : std_logic_vector(2 downto 0);
signal PCout : std_logic_vector(15 downto 0);
 
begin
    Stack: Pila Port map(
        clk => clk,
        clr => clr,
        UP => UP,
        DW => DW,
        WPC => WPC,
        SPout => SPout,
        PCin => PCin,
        PCout => PCout
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
        variable V_PCo : STD_LOGIC_VECTOR(15 downto 0);
        variable V_SP : STD_LOGIC_VECTOR(2 downto 0);
    
    file ENTRADAS : TEXT;
        variable LINEA_E : line;
        variable V_PCi : STD_LOGIC_VECTOR(15 downto 0);
        variable V_CLR : STD_LOGIC;
        variable V_WPC : STD_LOGIC;
        variable V_UP : STD_LOGIC;
        variable V_DW : STD_LOGIC;
        
    variable CADENA : STRING(1 to 2);
    
    variable j : integer;
    
    begin 
        file_open(ENTRADAS, "C:\Users\ernes\Desktop\Arq\P10_Proyecto_Vivado\ESTIMULOS.txt", READ_MODE);
        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P10_Proyecto_Vivado\RESULTADO.txt", WRITE_MODE);
        
        CADENA := "SP";
        write(LINEA_R, CADENA, LEFT,3);
        
        CADENA := "PC";
        write(LINEA_R, CADENA, LEFT,5);
        
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
            V_SP := SPout;
            
            j := conv_integer(unsigned(SPout));
            
            write(LINEA_R, j, left, 3);
            Hwrite(LINEA_R, V_PCo, left, 5);
            
            writeline(SALIDAS, LINEA_R);
        end loop;
        
        file_close(SALIDAS);
        file_close(ENTRADAS);            
        wait;
    end process;       

end TB;