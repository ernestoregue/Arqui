library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity UCTB is
end UCTB;

architecture TB of UCTB is
component UC is
    Port(
        FC, FLAGS: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        OPC : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        CLK, CLR, FL : in STD_LOGIC;
        M : out STD_LOGIC_VECTOR(19 DOWNTO 0);
        LEVEL : out STD_LOGIC;
        DEC : out STD_LOGIC_VECTOR(6 downto 0);
        COND : out STD_LOGIC_VECTOR(5 downto 0);
        SD, SMI : out STD_LOGIC
        );    
end component;

signal FC, FLAGS: STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal OPC : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
signal CLK, CLR, FL, NIVEL : STD_LOGIC := '0';
signal M : STD_LOGIC_VECTOR(19 DOWNTO 0);
signal DEC : STD_LOGIC_VECTOR(6 downto 0);
signal COND : STD_LOGIC_VECTOR(5 downto 0);
signal SD,SMI : STD_LOGIC;


begin
    CONTROL : UC
    Port map(
        FC => FC,
        FLAGS => FLAGS,
        OPC => OPC,
        CLK => CLK,
        CLR => CLR,
        FL => FL,
        M => M,
        LEVEL => NIVEL,
        DEC => DEC,
        COND => COND,
        SD => SD,
        SMI => SMI
        ); 
--    reset : process
--    begin
--        CLR <= '1';
--        wait for 15 ns;
--        clr <= '0';
--        wait;
--    end process;

    reloj : process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;
    
--    process
--    begin
--        OPC <= "01101";
--        FLAGS <= "1111";
--        FL <= '1';
--        wait;
--    end process;
--    general : process
--    begin
--        FC <= "0001";
--        wait for 20 ns;
--        OPC <= "01101";
--        FL <= '1';
--        FLAGS <= "0010";
--        wait;
--    end process;
    
    
    process
    file SALIDAS : TEXT;
        variable LINEA_R : line;
        variable V_OPC : STD_LOGIC_VECTOR(4 downto 0);
        variable V_FC : STD_LOGIC_VECTOR(3 downto 0);
        variable V_FLAGS : STD_LOGIC_VECTOR(3 downto 0);
        variable V_CLR : STD_LOGIC;
        variable V_FL : STD_LOGIC;
    
    file ENTRADAS : TEXT;
        variable LINEA_E : line;
        variable V_MICRO: STD_LOGIC_VECTOR(19 downto 0);
        variable V_NIVEL : STD_LOGIC;
        
    variable CADENA : STRING(1 to 6);
    variable MI : STRING(1 to 16);
    variable UNIT : STRING(1 to 3);
    variable L : STRING(1 to 4) := "BAJO";
    variable H : STRING(1 to 4) := "ALTO";
    variable INS : STRING(1 TO 19):= "MICROINSTRUCCION N.";
 
	begin
        file_open(ENTRADAS, "C:\Users\ernes\Desktop\Arq\P14_Proyecto_Vivado\ENTRADAS.txt", READ_MODE);
        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\P14_Proyecto_Vivado\RESULTADO.txt", WRITE_MODE);
        
        CADENA := "OPCODE";
        write(LINEA_R, CADENA, LEFT,7);
        
        CADENA := "FCODE ";
        write(LINEA_R, CADENA, LEFT,7);
        
        CADENA := "FLAGS ";
        write(LINEA_R, CADENA, LEFT,7);
        
        UNIT := "CLR";
        write(LINEA_R, UNIT, LEFT,4);
        
        UNIT := "LF ";
        write(LINEA_R, UNIT, LEFT,4);
        
        MI := "MICROINSTRUCCION";
        write(LINEA_R, MI, LEFT,21);
        
        CADENA := "NIVEL ";
        write(LINEA_R, CADENA, LEFT,7);
      
        writeline(SALIDAS, LINEA_R);
               
        for i in 0 to 51 loop
            readline(ENTRADAS, LINEA_E);
            --LEE OPCODE
            read(LINEA_E,V_OPC);
            OPC <= V_OPC;
            --LEE FUNCODE
            read(LINEA_E,V_FC);
            FC <= V_FC;
            --LEE BANDERAS
            read(LINEA_E,V_FLAGS);
            FLAGS <= V_FLAGS;
            --LEE CLEAR
            read(LINEA_E,V_CLR);
            CLR <= V_CLR;
            --LEE LF
            read(LINEA_E,V_FL);
            FL <= V_FL;
            
            wait until falling_edge(CLK);
            
	        V_MICRO := M;
	        V_NIVEL := NIVEL;
	        
	        write(LINEA_R, INS,left, 20);
	        write(LINEA_R, i+1,left,2);
	        writeline(SALIDAS, LINEA_R);
	        
            write(LINEA_R,OPC,left, 7);
            write(LINEA_R,FC,left, 7);
            write(LINEA_R,FLAGS,left,7);
            write(LINEA_R,CLR,left,4);
            write(LINEA_R,FL,left,4);
            write(LINEA_R,V_MICRO,left,21);
            
            if CLR = '1' then
                write(LINEA_R,L,left,7);
            else  
                write(LINEA_R,H,left,7);  
            end if;
                           
            writeline(SALIDAS, LINEA_R);
            
	        wait until rising_edge(CLK);
	        
            V_MICRO := M;
	        V_NIVEL := NIVEL;
	        
            write(LINEA_R,OPC,left, 7);
            write(LINEA_R,FC,left, 7);
            write(LINEA_R,FLAGS,left,7);
            write(LINEA_R,CLR,left,4);
            write(LINEA_R,FL,left,4);
            write(LINEA_R,V_MICRO,left,21);
            write(LINEA_R,L,left,7);
  
	        writeline(SALIDAS, LINEA_R);

        end loop;
    file_close(ENTRADAS);
    file_close(SALIDAS);
    wait; 
	
	end process;
end TB;
