library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBenchALU1 is
--  Port ( );
end TestBenchALU1;

architecture TEST of TestBenchALU1 is

component ALU is
    Port ( a,b,cin, sela, selb: in STD_LOGIC;
           s,cout : out STD_LOGIC;
           operaciones : in STD_LOGIC_VECTOR (1 downto 0));
end component;
signal a,b,cin, sela, selb, s,cout: STD_LOGIC;
signal operaciones: STD_LOGIC_VECTOR(1 downto 0);

begin

    ALUbit1 : ALU
    Port map(
    a   => a,
    b   => b,
    cin =>cin,
    sela=>sela,
    selb=>selb,
    s   =>s,
    cout=>cout,
    operaciones => operaciones
    );
    
process
begin
    a<='1';
    b<='1';
    cin<='0';
    sela<='1';
    selb<='0';
    operaciones<="10";
    wait for 100ns;
end process;
    
end TEST;
