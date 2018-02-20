----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2018 06:10:34 PM
-- Design Name: 
-- Module Name: constantPckg - Behavioral
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
--      during implementation some constants are needed and they are stored here.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constantPckg is
 
 
-- DECODER CONSTANTS
constant I_OP_BEGIN :integer := 15;
constant I_OP_END   :integer := 12;
constant I_rD_BEGIN :integer := 11;
constant I_rD_END   :integer := 9;
constant I_FLAG     :integer := 8;
constant I_rA_BEGIN :integer := 7;
constant I_rA_END   :integer := 5;
constant I_rB_BEGIN :integer := 4;
constant I_rB_END   :integer := 2;

constant I_IMM_BEGIN:integer := 7;
constant I_IMM_END  :integer := 0;
 
-- INSTRUCTIONS SET, OPCODES
constant OP_ADD:    std_logic_vector(3 downto 0) :=  "0000";	-- ADD
constant OP_SUB:    std_logic_vector(3 downto 0) :=  "0001";	-- SUB 
constant OP_OR:     std_logic_vector(3 downto 0) :=  "0010";	-- OR 
constant OP_XOR:    std_logic_vector(3 downto 0) :=  "0011";	-- XOR 
constant OP_AND:    std_logic_vector(3 downto 0) :=  "0100";	-- AND 
constant OP_NOT:    std_logic_vector(3 downto 0) :=  "0101";	-- NOT 
constant OP_READ:   std_logic_vector(3 downto 0) :=  "0110";	-- READ 
constant OP_WRITE:  std_logic_vector(3 downto 0) :=  "0111";	-- WRITE 
constant OP_LOAD:   std_logic_vector(3 downto 0) :=  "1000";	-- LOAD 
constant OP_CMP:    std_logic_vector(3 downto 0) :=  "1001";	-- CMP 
constant OP_SHL:    std_logic_vector(3 downto 0) :=  "1010";	-- SHL 
constant OP_SHR:    std_logic_vector(3 downto 0) :=  "1011";    -- SHR 
constant OP_JUMP:   std_logic_vector(3 downto 0) :=  "1100";	-- JUMP 
constant OP_JUMPEQ: std_logic_vector(3 downto 0) :=  "1101";	-- JUMPEQ 
constant OP_SPEC:   std_logic_vector(3 downto 0) :=  "1110";	-- SPECIAL
constant OP_RES2:   std_logic_vector(3 downto 0) :=  "1111";    -- RESERVED 

-- Conditional jump flags
constant CJF_EQ:  std_logic_vector(2 downto 0):= "000";
constant CJF_AZ:  std_logic_vector(2 downto 0):= "001";
constant CJF_BZ:  std_logic_vector(2 downto 0):= "010";
constant CJF_ANZ: std_logic_vector(2 downto 0):= "011";
constant CJF_BNZ: std_logic_vector(2 downto 0):= "100";
constant CJF_AGB: std_logic_vector(2 downto 0):= "101";
constant CJF_ALB: std_logic_vector(2 downto 0):= "110";

-- cmp output bits
constant CMP_BIT_EQ:  integer := 14;
constant CMP_BIT_AGB: integer := 13;
constant CMP_BIT_ALB: integer := 12;
constant CMP_BIT_AZ:  integer := 11;
constant CMP_BIT_BZ:  integer := 10;

-- PIPELINE States
constant PIP_FETCH: integer := 1;
constant PIP_DEC:   integer := 2;
constant PIP_REGR:  integer := 4;
constant PIP_ALU:   integer := 8;
constant PIP_WRITE: integer := 16;


end constantPckg;
