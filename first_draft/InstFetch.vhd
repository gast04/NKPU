----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 02:46:47 PM
-- Design Name: 
-- Module Name: InstFetch - Behavioral
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



entity InstFetch is
 Port (
   I_clk : in  STD_LOGIC;
   I_en :  in  STD_LOGIC;
   I_dataA :   in STD_LOGIC_VECTOR (15 downto 0);
   I_dataB :   in STD_LOGIC_VECTOR (15 downto 0);
   I_dataDwe : in STD_LOGIC;
   I_aluop :   in STD_LOGIC_VECTOR (4 downto 0);
   I_PC :      in STD_LOGIC_VECTOR (15 downto 0);
   I_dataIMM : in STD_LOGIC_VECTOR (15 downto 0);
   O_dataResult :   out  STD_LOGIC_VECTOR (15 downto 0);
   O_dataWriteReg : out STD_LOGIC;
   O_shouldBranch : out STD_LOGIC
 );
end InstFetch;

architecture Behavioral of InstFetch is

begin


end Behavioral;
