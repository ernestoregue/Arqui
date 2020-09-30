library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UdCTB is end UdCTB;

architecture TB of UdCTB is

component UdC is
    Port(
        DEC : in STD_LOGIC_VECTOR(6 DOWNTO 0);
        COND : in STD_LOGIC_VECTOR(5 DOWNTO 0);
        NA, CLK,CLR : in STD_LOGIC;
        SDOPC, SM : out STD_LOGIC
		);
end component;

component NIVEL is
    Port (
        CLK,CLR : in STD_lOGIC;
        NA : out STD_LOGIC
        );
end component;

component DECI is
    Port(
        DIR : in STD_LOGIC_VECTOR(4 downto 0);
        ITT : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

signal BDEC : STD_LOGIC_VECTOR(6 DOWNTO 0);
signal BNA,BFL : STD_LOGIC := '0';
signal BCON : STD_LOGIC_VECTOR(5 DOWNTO 0) := (others => '0');
signal CLK	: STD_LOGIC;
signal CLR	: STD_LOGIC := '0';
signal SDOPC, SM : STD_LOGIC;
begin
    Unidad_de_control : UdC
    Port map(
        DEC => BDEC,
        COND => BCON,
        NA => BNA,
        SDOPC => SDOPC,
        SM => SM,
        CLK => CLK,
        CLR => CLR
        );
    reloj : process
    begin
        clk <= '0';
        BNA <= '0';
        wait for 5 ns;
        clk <= '1';
        BNA <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
    BDEC <= "0100000";
    BCON <= "100000";
    wait;
    end process;
        
--    process
--    begin
--        BDEC <= "0000000";
--        wait for 5 ns;
--        BDEC <= "1000000";
--        wait for 5 ns;
--        BDEC <= "0100000";
            
--            wait until falling_edge(CLK);
--            BFL <= '1';
           
--            BCON <= "011100";
--            wait until rising_edge(CLK);
      
--            wait until falling_edge(CLK);
--            BFL <= '1';

--            BCON <= "010011";
--            wait until rising_edge(CLK);
 
--            wait until falling_edge(CLK);
--            BFL <= '1';
     
--            BCON <= "101100";
--            wait until rising_edge(CLK);
     
--            wait until falling_edge(CLK);
--            BFL <= '1';
     
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--        BDEC <= "0010000";
   
--            wait until falling_edge(CLK);
--            BFL <= '1';
      
--            BCON <= "011100";
--            wait until rising_edge(CLK);
        
--            wait until falling_edge(CLK);
--            BFL <= '1';
       
--            BCON <= "010011";
--            wait until rising_edge(CLK);
          
--            wait until falling_edge(CLK);
--            BFL <= '1';
         
--            BCON <= "101100";
--            wait until rising_edge(CLK);
         
--            wait until falling_edge(CLK);
--            BFL <= '1';
        
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--        BDEC <= "0001000";
      
--            wait until falling_edge(CLK);
--            BFL <= '1';
        
--            BCON <= "011100";
--            wait until rising_edge(CLK);
        
--            wait until falling_edge(CLK);
--            BFL <= '1';
           
--            BCON <= "010011";
--            wait until rising_edge(CLK);
        
--            wait until falling_edge(CLK);
--            BFL <= '1';
         
--            BCON <= "101100";
--            wait until rising_edge(CLK);
            
--            wait until falling_edge(CLK);
--            BFL <= '1';
       
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--        BDEC <= "0000100";
        
--            wait until falling_edge(CLK);
--            BFL <= '1';
          
--            BCON <= "011100";
--            wait until rising_edge(CLK);
       
--            wait until falling_edge(CLK);
--            BFL <= '1';
       
--            BCON <= "010011";
--            wait until rising_edge(CLK);
         
--            wait until falling_edge(CLK);
--            BFL <= '1';
          
--            BCON <= "101100";
--            wait until rising_edge(CLK);
         
--            wait until falling_edge(CLK);
--            BFL <= '1';
           
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--        BDEC <= "0000010";
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "011100";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "010011";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "101100";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--        BDEC <= "0000001";
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "011100";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "010011";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "101100";
--            wait until rising_edge(CLK);
--            BNA <= '0';
--            wait until falling_edge(CLK);
--            BFL <= '1';
--            BNA <= '1';
--            BCON <= "100101";
--            wait until rising_edge(CLK);
--    end process;
end TB;
