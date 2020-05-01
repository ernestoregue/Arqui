library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumaAATB is
--  Port ( );
end SumaAATB;

architecture TestBench of SumaAATB is
    component SumaAA is
    Port ( 
    a,b     : in STD_LOGIC_VECTOR (7 downto 0);
    cin     : in STD_LOGIC;
    s       : out STD_LOGIC_VECTOR (7 downto 0);
    cout    : out STD_LOGIC);
    end component;
    
    signal a,b  :  STD_LOGIC_VECTOR (7 downto 0);
    signal cin  :  STD_LOGIC;
    signal s    :  STD_LOGIC_VECTOR (7 downto 0);
    signal cout :  STD_LOGIC;
    
begin
    sumador :   SumaAA
        Port map(
        a=>a,
        b=>b,
        cin=>cin,
        s=>s,
        cout=>cout
        );
process
    begin
        cin<='0';
        a<="00000101";
        b<="00000101";
            wait for 100ns;
        cin<='0';
        a<="00001100";
        b<="00000111";
            wait for 100ns;
        cin<='0';
        a<="00001001";
        b<="00000101";
            wait for 100ns;
        cin<='1';
        a<="00001110";
        b<="00011001";
            wait for 100ns;
        cin<='0';
        a<="00000100";
        b<="00000010";
            wait for 100ns;
        cin<='0';
        a<="00000111";
        b<="00000111";
            wait for 100ns;
        cin<='0';
        a<="00001111";
        b<="00000101";
            wait for 100ns;
        cin<='0';
        a<="00001011";
        b<="00001000";
            wait for 100ns;
        cin<='0';
        a<="00000001";
        b<="00000100";
            wait;

end process;


end TestBench;
