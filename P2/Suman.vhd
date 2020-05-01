library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Suman is
    generic( n  :   integer :=  8 );
    Port ( 
        a, b    : in STD_LOGIC_VECTOR (n-1 downto 0);
        cin     : in STD_LOGIC;
        s       : out STD_LOGIC_VECTOR(n-1 downto 0);
        cout    : out STD_LOGIC
        );
end Suman;

architecture Suman_Arq of Suman is
    
component Suma1 is
    Port ( 
    a, b, cin   : in STD_LOGIC;
    s, cout     : out STD_LOGIC
    );
end component;

signal eb   : STD_LOGIC_VECTOR(n-1 downto 0);
signal c    : STD_LOGIC_VECTOR(n downto 0);

begin
    c(0)    <= cin;
    
    genera : for i in 0 to n-1 generate
        eb(i)<= b(i) xor c(0);
        bits : Suma1
            Port map(
                a   =>  a(i),
                b   =>  eb(i),
                cin =>  c(i),
                s   =>  s(i),
                cout   =>  c(i+1)
                );
    end generate;
    
    cout    <= c(n);
    
end Suman_Arq;
