library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBenchALUN is
--  Port ( );
end TestBenchALUN;

architecture TB of TestBenchALUN is

component ALUN is
    Port ( a,b      : in STD_LOGIC_VECTOR(3 downto 0);
           opera    : in STD_LOGIC_VECTOR(3 downto 0); 
           res      : inout STD_LOGIC_VECTOR(3 downto 0);
           N,C,OV   : out STD_LOGIC;
           Z        : inout STD_LOGIC
           );
end component;

signal a,b: STD_LOGIC_VECTOR(3 downto 0);
signal opera: STD_LOGIC_VECTOR(3 downto 0);
signal res: STD_LOGIC_VECTOR(3 downto 0);
signal N,C,OV,Z : STD_LOGIC;

begin

    ALUP : ALUN
       Port map(
       a    => a,
       b    => b,
       opera=>opera,
       res  =>res,
       N    =>N,
       C    =>C,
       OV   =>OV,
       Z    =>Z
       );
       
process
    begin
    a<="0101";
    b<="1110";
    opera<="0011";
    wait for 50ns;
    opera<="0111";
    wait for 50ns;
    opera<="0000";
    wait for 50ns;
    opera<="1101";
    wait for 50ns;
    opera<="0001";
    wait for 50ns;
    opera<="1100";
    wait for 50ns;
    opera<="0010";
    wait for 50ns;
    opera<="0110";
    wait for 50ns;
    
    a<="0101";
    b<="0111";
    
    opera<="0011";
    wait for 50ns;
    
    a<="0101";
    b<="0101";
    
    opera<="0111";
    wait for 50ns;
    opera<="1101";
    wait for 50ns;
    
end process;    

end TB;
