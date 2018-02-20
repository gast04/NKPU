----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2018 03:34:32 PM
-- Design Name: 
-- Module Name: reg16_8_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg16_8_tb is
end reg16_8_tb;

architecture behaviour of reg16_8_tb is

  component reg16_8
    Port ( I_clk : in STD_LOGIC;
         I_en : in STD_LOGIC;
         I_dataD : in STD_LOGIC_VECTOR (15 downto 0);
         O_dataA : out STD_LOGIC_VECTOR (15 downto 0);
         O_dataB : out STD_LOGIC_VECTOR (15 downto 0);
         I_selA : in STD_LOGIC_VECTOR (2 downto 0);
         I_selB : in STD_LOGIC_VECTOR (2 downto 0);
         I_selD : in STD_LOGIC_VECTOR (2 downto 0);
         I_we : in STD_LOGIC);
  end component;

  -- inputs
  signal I_clk: STD_LOGIC := '0';
  signal I_en: STD_LOGIC := '0' ;
  signal I_dataD: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
  signal I_selA: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
  signal I_selB: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
  signal I_selD: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
  signal I_we: STD_LOGIC := '0';      
  
  -- outputs
  signal O_dataA: STD_LOGIC_VECTOR (15 downto 0);
  signal O_dataB: STD_LOGIC_VECTOR (15 downto 0);

  -- Clock period definitions
  constant I_clk_period : time := 10 ns;

begin

    -- uut = unit under test
    uut: reg16_8 port map ( I_clk   => I_clk,
                        I_en    => I_en,
                        I_dataD  => I_dataD,
                        O_dataA => O_dataA, 
                        O_dataB => O_dataB, 
                        I_selA => I_selA,
                        I_selB => I_selB,
                        I_selD => I_selD,
                        I_we => I_we);
                        
    -- Clock process definitions
    I_clk_process :process
    begin
        I_clk <= '0';
        wait for I_clk_period/2;
        I_clk <= '1';
        wait for I_clk_period/2;
    end process;                  


    testing :process
    begin
    
        -- wait 100ns
        wait for 100ns;
        
        
        
        -- stestcase 1
        -- select registers
        I_selA <= "000"; -- reg0
        I_selB <= "001"; -- reg1
        I_selD <= "000"; -- reg0
                        
        I_dataD <= X"1234"; -- input data
        I_en <= '1';        -- enable the register module
        I_we <= '1';        -- enable writing to register
        
        wait for I_clk_period*3;
        
        
        -- testcase 2
        I_selA <= "000"; -- reg0
        I_selB <= "001"; -- reg1
        I_selD <= "010"; -- reg2
                
        I_dataD <= X"C0FE"; -- input data
        I_en <= '1';        -- enable the register module
        I_we <= '0';
        wait for I_clk_period;
        I_we <= '1';   
        I_selB <= "010"; -- reg2
        
        wait for I_clk_period*3;
        
        
    end process;


end;
