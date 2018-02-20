----------------------------------------------------------------------------------
-- Company: 
-- Engineer:    NiKu
-- 
-- Create Date: 01/29/2018 11:47:48 AM
-- Design Name: 
-- Module Name: register_dummy - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Sample Register File for testing how simulation works 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_dummy is
    Port ( I_clk : in STD_LOGIC;
           I_en : in STD_LOGIC;
           I_data : in STD_LOGIC_VECTOR (15 downto 0);
           O_dataA : out STD_LOGIC_VECTOR (15 downto 0));
end register_dummy;

architecture Behavioral of register_dummy is
 	signal mem_reg: std_logic_vector(15 downto 0) := X"0000";
 	
 	 type store_t is array (0 to 7) of std_logic_vector(15 downto 0);
     signal regs: store_t := (others => X"0000");
 	
begin

  process(I_clk)
  begin
    if rising_edge(I_clk) and I_en='1' then
    	
    	-- set output to register value
	    O_dataA <= regs( 3 );
	    
	    -- if the enable=1 then update the register value
	    if (I_en = '1') then
	      regs(3) <= I_data;
	    end if;
	  
    end if;
  end process;

end Behavioral;
