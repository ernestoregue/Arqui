library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MP is
    generic( 
        m : integer := 10;
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
    COP(1) & R(0) & x"0000",--0
    COP(1) & R(1) & x"0001",--1
    COP(1) & R(2) & x"0000",--2
    COP(1) & R(3) & x"000C",--3
    
    COP(0) & R(4) & R(0) & R(1) & SU & CR(0),--4
    COP(3) & R(4) & x"0048",--5
    
    COP(5) & R(0) & R(1) & x"000",--6
    COP(5) & R(1) & R(4) & x"000",--7
    
    COP(5) & R(2) & R(2) & x"001",--8
    
    COP(14) & R(3) & R(2) & x"004",--9
    
    
    COP(22) & SU & SU & SU & SU & SU,--10
    COP(19) & SU & x"000A",--11
    --PRUEBA DE OTRAS INSTRUCCIONES
    COP(22) & SU & SU & SU & SU & SU,--12
    COP(22) & SU & SU & SU & SU & SU,--13
    COP(0) & R(4) & R(0) & R(1) & SU & CR(1),--14
    COP(0) & R(4) & R(0) & R(1) & SU & CR(2),--15
    COP(0) & R(4) & R(0) & R(1) & SU & CR(3),--16
    COP(0) & R(4) & R(0) & R(1) & SU & CR(4),--17
    COP(0) & R(4) & R(0) & R(1) & SU & CR(5),--18
    COP(0) & R(4) & R(0) & R(1) & SU & CR(6),--19
    COP(0) & R(4) & R(0) & R(1) & SU & CR(7),--20
    COP(0) & R(4) & R(0) & R(1) & SU & CR(8),--21
    COP(0) & R(4) & R(0) & SU & x"A" & CR(9),--22
    COP(0) & R(4) & R(0) & SU & x"F" & CR(10),--23
    
    COP(2) & R(5) & x"8421",--24
    COP(3) & R(5) & x"8421",--25
    
    COP(4) & R(5) & R(8) & x"421",--26
    COP(23) & R(5) & R(8) & x"421",--27
    
    COP(6) & R(2) & R(2) & x"001",--28
    
    COP(7) & R(2) & R(2) & x"001",--28
    COP(8) & R(2) & R(2) & x"001",--29
    COP(9) & R(2) & R(2) & x"001",--30
    COP(10) & R(2) & R(2) & x"001",--31
    COP(11) & R(2) & R(2) & x"001",--32
    COP(12) & R(2) & R(2) & x"001",--33
    
    COP(13) & R(2) & R(2) & x"FFF",--34
    COP(14) & R(2) & R(2) & x"FFF",--35
    COP(15) & R(2) & R(2) & x"FFF",--36
    COP(16) & R(2) & R(2) & x"FFF",--37
    COP(17) & R(2) & R(2) & x"FFF",--38
    COP(18) & R(2) & R(2) & x"FFF",--39
    
    COP(20) & SU & x"FFEE",--40
    COP(22) & SU & SU & SU & SU & SU,--41
    others => (others => '0')
    );
    
begin
ITT<= DEFAULT_PROGRAM(conv_integer(DIR));
end A_TP;
