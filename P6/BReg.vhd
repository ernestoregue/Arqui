library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BReg is
--  Port ( );
end BReg;

architecture TB of BReg is

component Reg is
    Port ( D    : in STD_LOGIC_VECTOR (15 downto 0);
           Q    : out STD_LOGIC_VECTOR (15 downto 0);
           L    : in STD_LOGIC;
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC);    
end component;

signal D    : STD_LOGIC_VECTOR (15 downto 0);
signal Q    : STD_LOGIC_VECTOR (15 downto 0);
signal L    : STD_LOGIC;
signal CLK  : STD_LOGIC;
signal CLR  : STD_LOGIC;
 
    begin
        reloj : process
        begin
            CLK <= '0';
            wait for 5 ns;
            CLK <= '1';
            wait for 5 ns;
        end process;
        
        Registro : Reg
            Port map(
            D=>D,
            Q=>Q,
            L=>L,
            CLK=>CLK,
            CLR=>CLR);
        
        process
            begin
                CLR<='1';
                wait for 10 ns;
                
                CLR<='0';
                D <= x"00AA";
                L <='0';
                wait for 10 ns;
                
                D <= x"0010";
                wait for 10 ns;
                
                L <='1';
                wait for 10 ns;
                
                L <='0';
                D <= x"0DBB";
                wait for 10 ns;
                
                L <='1';
                D <= x"76AF";
                wait for 10 ns;
                
                CLR<='1';
                wait;
                
        end process;

end TB;
