library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BTB is

end BTB;

architecture TB of BTB is
component BANDERAS is
    Port(
        CLR, CLK, FL : in STD_LOGIC;
        B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end component;
signal CLK,CLR,FL: STD_LOGIC := '0';
signal B, Q : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
begin
    REG_BANDERAS : BANDERAS
    Port map(
        CLR => CLR,
        CLK => CLK,
        FL => FL,
        B => B,
        Q => Q
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
        wait for 20 ns;
        CLR <= '0';
        for j in 0 to 15 loop
            FL<= '0';
            B <= conv_std_logic_vector(j,B'length);
            wait for 10 ns;
            FL <= '1';
            B <= conv_std_logic_vector(j,B'length);
            wait for 10 ns;
        end loop;          
    end process;       
end TB;
