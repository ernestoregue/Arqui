library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MTB is
--  Port ( );
end MTB;

architecture TB of MTB is

component OPCODEM is
    Port(
        OPCODE : in STD_LOGIC_VECTOR(4 downto 0);
        MIC : out STD_LOGIC_VECTOR(19 downto 0)
    );
end component;
component MFC is
    Port(
        FUNCODE : in STD_LOGIC_VECTOR(3 downto 0);
        MICRO : out STD_LOGIC_VECTOR(19 downto 0)
    );
end component;

signal B3 : STD_LOGIC_VECTOR(4 downto 0);
signal B2 : STD_LOGIC_VECTOR(19 downto 0);
signal FC : STD_LOGIC_VECTOR(3 downto 0);
signal B0 : STD_LOGIC_VECTOR(19 downto 0);
begin
    A0 : OPCODEM
    Port map(
        OPCODE => B3,
        MIC => B2
        );
    A1 : MFC
    Port map(
        FUNCODE => FC,
        MICRO => B0
        );
    MOPC : process
    begin
        for i in 0 to 31 loop
            B3 <= conv_std_logic_vector(i,B3'length);
            wait for 10 ns;
        end loop;
        for j in 0 to 15 loop
            FC <= conv_std_logic_vector(j,FC'length);
            wait for 10 ns;
        end loop;
    end process MOPC;
end TB;
