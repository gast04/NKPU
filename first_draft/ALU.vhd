----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2018 05:54:49 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
--      Important is that every case only costs one cycle
--      to prevent timing conflicts 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constantPckg.all;

entity ALU is Port (
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
    O_shouldBranch : out STD_LOGIC;
    O_PC : out STD_LOGIC_VECTOR (15 downto 0)
  );
end ALU;

architecture Behavioral of ALU is

  -- store in 17 bit vector because of overflow and carry bits
  -- OVERFLOW HANDLING -> TODO
  signal op_result: STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
  signal s_shouldBranch: STD_LOGIC := '0';
  signal pc_changed: STD_LOGIC := '0';
  signal pc: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
  begin
  
  process (I_clk, I_en)
  begin

  if rising_edge(I_clk) and I_en = '1' then
    O_dataWriteReg <= I_dataDwe;
    s_shouldBranch <= '0';
      
    -- case over OPCODES without FLAG bit
    case I_aluop(4 downto 1) is
      
      -- ADD-OPCODE HANDLING
      when OP_ADD =>
        -- FLAG = 1 -> signed add | FLAG = 0 -> unsigned add
        if I_aluop(0) = '0' then
          op_result <= std_logic_vector(unsigned('0' & I_dataA) + unsigned( '0' & I_dataB));
        else
          op_result <= std_logic_vector(signed(I_dataA(15) & I_dataA) + signed( I_dataB(15) & I_dataB));
        end if;
 
      -- SUB-OPCODE HANDLING
      when OP_SUB =>
        -- FLAG = 1 -> signed sub | FLAG = 0 -> unsigned sub
        if I_aluop(0) = '0' then
          op_result <= std_logic_vector(unsigned('0' & I_dataA) - unsigned( '0' & I_dataB));
        else
          op_result <= std_logic_vector(signed(I_dataA(15) & I_dataA) - signed( I_dataB(15) & I_dataB));
        end if;
        
      -- OR-OPCODE HANDLING
      when OP_OR => 
        op_result <= '0' & (I_dataA or I_dataB);
        
      -- XOR-OPCODE HANDLING
      when OP_XOR =>
        op_result <= '0' & (I_dataA xor I_dataB);
        
      -- AND-OPCODE HANDLING
      when OP_AND => 
        op_result <= '0' & (I_dataA and I_dataB);
        
      -- NOT-OPCODE HANDLING
      when OP_NOT =>
        op_result <= '0' & (not I_dataA);
        
      -- READ-OPCODE HANDLING
      when OP_READ =>
        -- TODO
        -- MEMORY HANDLING is MISSING
        op_result <= "0" & X"FEFE";
        
      -- WRITE-OPCODE HANDLING
      when OP_WRITE =>
        -- TODO
        -- MEMORY HANDLING is MISSING
        op_result <= "0" & X"FEFE";
        
      -- LOAD-OPCODE HANDLING
      when OP_LOAD =>
        -- FLAG = 0 load in HIGHbyte | FLAG = 1 load in LOWbyte
        if I_aluop(0) = '0' then
            op_result <= '0' & I_dataIMM(7 downto 0) & X"00";
        else 
            op_result <= '0' & X"00" & I_dataIMM(7 downto 0);
        end if;
      
      -- CMP-OPCODE HANDLING
      when OP_CMP => 
        -- TODO
        -- CMP-FLAG HANDLING is MISSING
        op_result <= "0" & X"FEFE";
        
      -- SHL-OPCODE HANDLING
      when OP_SHL => 
        case I_dataB(3 downto 0) is
        when X"1" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 1) );
        when X"2" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 2) );
        when X"3" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 3) );
        when X"4" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 4) );
        when X"5" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 5) );
        when X"6" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 6) );
        when X"7" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 7) );
        when X"8" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 8) );
        when X"9" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 9) );
        when X"A" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 10) );
        when X"B" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 11) );
        when X"C" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 12) );
        when X"D" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 13) );
        when X"E" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 14) );
        when X"F" => op_result <= '0' & std_logic_vector( shift_left(unsigned(I_dataA), 15) );
        when others => op_result <= '0' & I_dataA;
        end case;
 
      -- SHR-OPCODE HANDLING
      when OP_SHR => 
        case I_dataB(3 downto 0) is
        when X"1" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 1) );
        when X"2" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 2) );
        when X"3" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 3) );
        when X"4" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 4) );
        when X"5" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 5) );
        when X"6" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 6) );
        when X"7" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 7) );
        when X"8" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 8) );
        when X"9" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 9) );
        when X"A" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 10) );
        when X"B" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 11) );
        when X"C" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 12) );
        when X"D" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 13) );
        when X"E" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 14) );
        when X"F" => op_result <= '0' & std_logic_vector( shift_right(unsigned(I_dataA), 15) );
        when others => op_result <= '0' & I_dataA;
        end case;
                          
      -- JUMP-OPCODE HANDLING
      when OP_JUMP =>
        -- TODO
        -- PC HANDLING is MISSING
        op_result <= "0" & X"FEFE";
        pc_changed <= '1';
      
      -- JUMP-OPCODE HANDLING
      when OP_JUMPEQ =>
        -- TODO
        -- PC HANDLING is MISSING
        op_result <= "0" & X"FEFE";
        pc_changed <= '1';
          
      -- Other OPCODEs (no Implementation)
      when others =>
        op_result <= "0" & X"FFFF";
      end case;
      
      -- increase Program Counter
      if pc_changed = '0' then
        pc <= std_logic_vector(unsigned(I_PC) + 1);  
      end if;
      
    end if;
  end process;
  
    -- write result to out (clock independent)
    O_dataResult <= op_result(15 downto 0);
    O_shouldBranch <= s_shouldBranch;
    O_PC <= pc;
    
end Behavioral;



