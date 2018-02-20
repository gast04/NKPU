

package helperConstants is
  constant SOME_FLAG : bit_vector := "11111111";
  type STATE is (RESET,IDLE,ACKA);
  component HALFADD 
    port(A,B : in bit;
         SUM,CARRY : out bit);
  end component;
end helperConstants;