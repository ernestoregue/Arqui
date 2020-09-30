library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NTB is

end NTB;

architecture TB of NTB is

component NIVEL is
    Port (
        CLK,CLR : in STD_lOGIC;
        NA : out STD_LOGIC
        );
end component;
signal CLK,CLR,NA : STD_LOGIC;

begin
    Bloque_de_nivel : NIVEL
    Port map(
        CLK => CLK,
        CLR => CLR,
        NA => NA
        );
    
    reloj : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        CLR <= '1';
        wait for 3 ns;
        clr <= '0';
        wait;
    end process;
    
end TB;
