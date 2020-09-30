library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Busqueda is
    Generic(
        m : integer := 10;
        n : integer := 3;
        o : integer := 25
    ); 
	Port(
		CLK,CLR,UP,DW,WPC : in STD_LOGIC;
		PCin : in STD_LOGIC_VECTOR(m-1 downto 0);
		SPout : inout STD_LOGIC_VECTOR(n-1 downto 0);
		PCout : out STD_LOGIC_VECTOR(o-1 downto 0);
		PCS : inout STD_LOGIC_VECTOR(m-1 downto 0)
	);
end Busqueda;

architecture A_B of Busqueda is
component Pila is
    Port(
        PCin : in STD_LOGIC_VECTOR(m-1 downto 0);   
        CLK,CLR,WPC,UP,DW: in STD_LOGIC;
        PCout : out STD_LOGIC_VECTOR(m-1 downto 0); 
        SPout : inout STD_LOGIC_VECTOR(n-1 downto 0) 
    );
end component;
component MP is
    Port(
        DIR : in STD_LOGIC_VECTOR(m-1 downto 0);
        ITT : out STD_LOGIC_VECTOR(o-1 downto 0)
    );
end component;

begin
    Stack: Pila Port map(
        clk => clk,
        clr => clr,
        UP => UP,
        DW => DW,
        WPC => WPC,
        SPout => SPout,
        PCin => PCin,
        PCout => PCS
    );
    MemProg : MP Port map(
        DIR=> PCS,
        ITT=> PCout
    );
    
    
end A_B;