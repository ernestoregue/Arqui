library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MP is
    generic( 
        m : integer := 16;
        n : integer := 25
        );
    Port(
        DIR : in STD_LOGIC_VECTOR(m-1 downto 0);
        ITT : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end MP;

architecture A_TP of MP is

TYPE CO IS ARRAY (0 TO 23) OF STD_lOGIC_VECTOR(4 DOWNTO 0);
TYPE REG IS ARRAY (0 TO 15) OF STD_lOGIC_VECTOR(3 DOWNTO 0);
TYPE COR IS ARRAY (0 TO 10) OF STD_lOGIC_VECTOR(3 DOWNTO 0);

CONSTANT R : REG := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A",x"B",x"C",x"D",x"E",x"F");
CONSTANT COP : CO := ("00000","00001","00010","00011","00100","00101","00110","00111",
                      "01000","01001","01010","01011","01100","01101","01110","01111",
                      "10000","10001","10010","10011","10100","10101","10110","10111");
CONSTANT SU : STD_LOGIC_VECTOR(3 downto 0) := "0000";
CONSTANT CR : COR := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A");
                 
TYPE BANCO IS ARRAY (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);       
CONSTANT DEFAULT_PROGRAM : BANCO :=(
    COP(1) & R(6) & x"0057",--0                     LI
    COP(1) & R(8) & x"005A",--1                     LI
    COP(0) & R(8) & R(2) & R(3) & SU & CR(0),--2    ADD
    COP(0) & R(1) & R(2) & R(3) & SU & CR(1),--3    SUB
    COP(20) & SU & x"0009",--4                      CALL
    COP(1) & R(6) & x"0057",--5                     LI
    COP(1) & R(8) & x"005A",--6                     LI
    COP(20) & SU & x"000D",--7                      CALL
    COP(0) & R(8) & R(2) & R(3) & SU & CR(0),--8    ADD
    COP(0) & R(1) & R(2) & R(3) & SU & CR(1),--9    SUB
    COP(1) & R(6) & x"0057",--10                    LI
    COP(21) & SU & SU & SU & SU & SU,--11           RET
    COP(0) & R(1) & R(2) & R(3) & SU & CR(1),--12   SUB
    COP(1) & R(6) & x"0057",--13                    LI
    COP(21) & SU & SU & SU & SU & SU,--14           RET
    COP(19) & SU & x"0012",--15                     B
    COP(22) & SU & SU & SU & SU & SU,--16           NOP
    COP(22) & SU & SU & SU & SU & SU,--17           NOP
    COP(19) & SU & x"0011",--18                     B
    others => (others => '0')
    );
    
begin
ITT<= DEFAULT_PROGRAM(conv_integer(DIR));
end A_TP;
