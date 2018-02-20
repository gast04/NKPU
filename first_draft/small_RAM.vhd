----------------------------------------------------------------------------------
-- Company: 
-- Engineer:  NiKu  
-- 
-- Create Date: 01/30/2018 08:10:25 PM
-- Design Name: 
-- Module Name: small_RAM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: just a small RAM for testing
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

library work;
use work.constantPckg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity small_RAM is
    Port ( I_clk : in STD_LOGIC;
           I_we : in STD_LOGIC;
           I_addr : in STD_LOGIC_VECTOR (15 downto 0);
           I_data : in STD_LOGIC_VECTOR (15 downto 0);
           O_data : out STD_LOGIC_VECTOR (15 downto 0));
end small_RAM;

architecture Behavioral of small_RAM is

    type store_t is array (0 to 7) of std_logic_vector(15 downto 0);
    --signal ram_16: store_t := (others => X"0000");
    
     signal ram_16: store_t := (
       OP_LOAD & "000" & '0' & X"fe",
       OP_LOAD & "001" & '1' & X"ed",
       OP_OR & "010" & '0' & "000" & "001" & "00",
       OP_LOAD & "011" & '1' & X"01",
       OP_LOAD & "100" & '1' & X"02",
       OP_ADD & "011" & '0' & "011" & "100" & "00",
       OP_OR & "101" & '0' & "000" & "011" & "00",
       OP_AND & "101" & '0' & "101" & "010" & "00"
       );
    
begin

    process (I_clk)
    begin
        if rising_edge(I_clk) then
            
            if ( I_we='1') then
                ram_16(to_integer(unsigned(I_addr(5 downto 0)))) <= I_data;
            else
                -- think about seperating input and output selection,
                -- we could always return the output selection
                O_data <= ram_16(to_integer(unsigned(I_addr(5 downto 0))));
            end if;    
    
        end if;
    end process;
    
end Behavioral;
