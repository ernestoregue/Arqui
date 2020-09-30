library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DTB is

end DTB;

architecture TB of DTB is
component DECI is
    Port(
        DIR : in STD_LOGIC_VECTOR(4 downto 0);
        ITT : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;
signal DIR : STD_LOGIC_VECTOR(4 downto 0);
signal IDE : STD_LOGIC_VECTOR(6 downto 0);
begin
    DECODIFICADOR : DECI
    Port map(
        DIR => DIR,
        ITT => IDE
        );
    process
    begin
        for i in 0 to 31 loop
            DIR <= conv_std_logic_vector(i,DIR'length);
            wait for 10 ns;
        end loop;
        wait;
    end process;
end TB;
