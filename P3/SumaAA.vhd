library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumaAA is
    generic( n  :   integer :=  8 );
    Port ( 
    a,b     : in STD_LOGIC_VECTOR (n-1 downto 0);
    cin     : in STD_LOGIC;
    s       : out STD_LOGIC_VECTOR (n-1 downto 0);
    cout    : out STD_LOGIC
    );
end SumaAA;

architecture SumaAA_Arq of SumaAA is
begin

process(a,b,cin)
    variable P, G, Eb           :   STD_LOGIC_VECTOR(n-1 downto 0);
    variable auxa, auxb, auxc   :   STD_LOGIC;
    variable C                  :   STD_LOGIC_VECTOR(n downto 0);
    
    begin
        C(0)    := cin;
        
        for i in 0 to n-1 loop
            Eb(i)   :=  b(i) xor C(0);   
            P(i)    :=  a(i) xor Eb(i);
            G(i)    :=  a(i) and Eb(i);
            S(i)    <=  P(i) xor C(i);
            
            auxa    :=  C(0);
            for j in 0 to i loop
                auxa    :=  auxa and P(j);
            end loop;
            auxb    :=  '0';
            for k in 0 to i-1 loop
                auxc    :=  '1';
                for m in k+1 to i loop
                    auxc    :=  auxc and P(m);
                end loop;
                auxb    :=  auxb or G(k);
            end loop;
            
       C(i+1)   :=  auxa or (auxb and auxc) or G(i);
       end loop;
   
       cout <=  C(n);
end process;
  
end SumaAA_Arq;
