----------------------------------------------------------------------------------
-- Company: 
-- Engineer: NiKu
-- 
-- Create Date: 01/29/2018 06:35:43 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: decoder of the instructions
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

-- Parameter description:
-- I_clk         :in : input clock
-- I_en          : in : enable the module
-- I_instruction : in  : 16 bit fetched raw Instruction
-- O_alu_op      : out : parsed Opcode plus Flag bit 
-- O_immediate   : out : parsed 16 bit Immediate value (two times the 8bit value)
-- O_we          : out : write enable, set if the opcode will write to the D-register 
-- O_selA        : out : register A select 
-- O_selB        : out : register B select
-- O_selD        : out : register D select

entity Decoder is
    Port ( I_clk : in STD_LOGIC;
           I_en : in STD_LOGIC;
           I_instruction : in STD_LOGIC_VECTOR (15 downto 0);
           O_alu_op : out STD_LOGIC_VECTOR (4 downto 0);
           O_immediate : out STD_LOGIC_VECTOR (15 downto 0);
           O_we : out STD_LOGIC;
           O_selA : out STD_LOGIC_VECTOR (2 downto 0);
           O_selB : out STD_LOGIC_VECTOR (2 downto 0);
           O_selD : out STD_LOGIC_VECTOR (2 downto 0));
end Decoder;

architecture Behavioral of Decoder is

begin

    process (I_clk)
    begin
        if rising_edge(I_clk) and I_en = '1' then
            
            -- split the instruction according to the specified instruction set
            O_selA <= I_instruction(I_rA_BEGIN downto I_rA_END);
            O_selB <= I_instruction(I_rB_BEGIN downto I_rB_END);
            O_selD <= I_instruction(I_rD_BEGIN downto I_rD_END);
            O_immediate <= I_instruction(I_IMM_BEGIN downto I_IMM_END) & 
                           I_instruction(I_IMM_BEGIN downto I_IMM_END);
            O_alu_op <= I_instruction(I_OP_BEGIN downto I_OP_END) & I_instruction(I_FLAG); 
            
            -- set write enable bit for register D
            case I_instruction(I_OP_BEGIN downto I_OP_END) is 
                when "0111" => -- WRITE to Memory
                    O_we <= '0';
                when "1100" => -- JUMP
                    O_we <= '0';
                when "1101" => -- JUMPEQ
                    O_we <= '0';
                when others => -- in all other cases we write to the D-register
                    O_we <= '1'; 
            end case;
            
        end if;
    end process;

end Behavioral;
