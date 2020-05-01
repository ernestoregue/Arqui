library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BBS is
end BBS;

architecture TB of BBS is

component BS is
    Port ( D : in   STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0);
           S : in   STD_LOGIC_VECTOR (3 downto 0);
           DIR:in   STD_LOGIC);
end component;

signal D : STD_LOGIC_VECTOR(15 downto 0);
signal Q : STD_LOGIC_VECTOR(15 downto 0);
signal S : STD_LOGIC_VECTOR(3 downto 0);
signal DIR:STD_LOGIC;
    
begin

Barrel : BS
    Port map(
    D   => D,
    Q   => Q,
    S   => S,
    DIR => DIR 
    );

process
    begin
    D<=x"0097";
    S<=x"3";
    DIR<='0';
    wait for 30 ns;
    D<=x"0097";
    S<=x"3";
    DIR<='1';
    wait for 30 ns;
    D<=x"0091";
    S<=x"4";
    DIR<='0';
    wait for 30 ns;
    D<=x"0091";
    S<=x"4";
    DIR<='1';
    wait;
end process;
    
end TB;
