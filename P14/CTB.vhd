library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTB is
end CTB;

architecture TB of CTB is
component CONDICION is
    Port (
        D : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR(5 DOWNTO 0)
        );
end component;
signal B0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal B1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
begin
    A3 : CONDICION
    Port map(
        D => B0,
        S => B1
        );
    process
    begin
        for j in 0 to 15 loop
            B0 <= conv_std_logic_vector(j,B0'length);
            wait for 10 ns;
        end loop;
        wait;
    end process;
end TB;
