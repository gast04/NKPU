----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2018 03:38:33 PM
-- Design Name: 
-- Module Name: controller - Behavioral
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

library work;
use work.constantPckg.ALL;

entity controller is
 Port ( I_clk : in  STD_LOGIC;
        I_reset : in  STD_LOGIC;
        O_state : out  STD_LOGIC_VECTOR (4 downto 0) );
end controller;

architecture Behavioral of controller is
    signal state : std_logic_vector(4 downto 0) := (others => '0');
begin

  process(I_clk)
  begin
    if rising_edge(I_clk) then
     
      if I_reset = '1' then
        -- reset state
        state <= "00001";
      else  
        -- simple counter, fixed statemachine
        case state is
          when "00001" => state <= "00010"; -- FETCH
          when "00010" => state <= "00100"; -- DECODE
          when "00100" => state <= "01000"; -- REG READ
          when "01000" => state <= "10000"; -- ALU
          when others  => state <= "00001"; -- WRITE BACK
        end case;
      end if;
   
    end if;
  end process;  
  
  -- make permanent 
  O_state <= state;
   
end Behavioral;
