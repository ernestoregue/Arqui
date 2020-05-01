library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BDEMUX is
--  Port ( );
end BDEMUX;

architecture TB of BDEMUX is

component DEMUX is
        Port( f : in STD_LOGIC;
             s : in  STD_LOGIC_VECTOR(3 downto 0);
             y : out STD_LOGIC_VECTOR(15 downto 0));
end component;
 
signal LE : STD_LOGIC;
signal wRe: STD_LOGIC_VECTOR(3 downto 0);
signal Bs: STD_LOGIC_VECTOR(15 downto 0);
begin
DM : DEMUX
        Port map(
            f=>LE,
            s=>wRe,
            y=>Bs
            );

    process
        begin
            LE<='0';
            wRe<="0000";
            wait for 10 ns;
            
            LE<='1';
            wRe<="0000";
            wait for 10 ns;
            wRe<="0001";
            wait for 10 ns;
            wRe<="0010";
            wait for 10 ns;
            wRe<="0011";
            wait for 10 ns;
            wRe<="0100";
            wait for 10 ns;
            wRe<="0101";
            wait for 10 ns;
            wRe<="0110";
            wait for 10 ns;
            wRe<="0111";
            wait for 10 ns;
            wRe<="1000";
            wait for 10 ns;
            wRe<="1001";
            wait for 10 ns;
            wRe<="1010";
            wait for 10 ns;
            wRe<="1011";
            wait for 10 ns;
            wRe<="1100";
            wait for 10 ns;
            wRe<="1101";
            wait for 10 ns;
            wRe<="1110";
            wait for 10 ns;
            wRe<="1111";
            wait for 10 ns;
            
            
            LE<='0';
            wRe<="0111";
            wait for 10 ns;
            wRe<="0110";
            wait for 10 ns;
            wRe<="0101";
            wait for 10 ns;
            wRe<="1010";
            wait;
    end process;
end TB;
