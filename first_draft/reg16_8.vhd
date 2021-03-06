----------------------------------------------------------------------------------
-- Company: 
-- Engineer: NiKu
-- 
-- Create Date: 01/29/2018 03:28:12 PM
-- Design Name: 
-- Module Name: reg16_8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Contains the CPU-Registers
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

entity reg16_8 is
    Port ( I_clk : in STD_LOGIC;
           I_en : in STD_LOGIC;
           I_dataD : in STD_LOGIC_VECTOR (15 downto 0);
           O_dataA : out STD_LOGIC_VECTOR (15 downto 0);
           O_dataB : out STD_LOGIC_VECTOR (15 downto 0);
           I_selA : in STD_LOGIC_VECTOR (2 downto 0);
           I_selB : in STD_LOGIC_VECTOR (2 downto 0);
           I_selD : in STD_LOGIC_VECTOR (2 downto 0);
           I_we : in STD_LOGIC);
end reg16_8;

architecture Behavioral of reg16_8 is
    -- define register storage
    type store_t is array (0 to 7) of std_logic_vector(15 downto 0);
    signal regs: store_t := (others => X"0000");
begin

    process (I_clk)
    begin
        if (rising_edge(I_clk) and I_en='1') then
        
            -- register handling
	        O_dataA <= regs( to_integer(unsigned(I_selA)) );
            O_dataB <= regs( to_integer(unsigned(I_selB)) );
                
            if ( I_we = '1' ) then
                regs(to_integer(unsigned(I_selD))) <= I_dataD;
            end if;
        
        end if;
    end process;

end Behavioral;
