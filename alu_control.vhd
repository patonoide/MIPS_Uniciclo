library ieee;
use ieee.std_logic_1164.all;

entity ula_control is
  port (
    instruction_in : in std_logic_vector(5 downto 0); -- funct
    alu_op : in std_logic_vector(2 downto 0);
    alu_op_out : out std_logic_vector(3 downto 0);
    jr : out std_logic
  );
end entity;

architecture behavioral of ula_control is

begin


    	process( instruction_in, alu_op)
    		begin
                jr <= '0';
                if alu_op = "111" then
                    alu_op_out <= "0110"; -- xor
                elsif alu_op = "110" then
                    alu_op_out <= "0010"; -- soma
                elsif alu_op = "001" then
                    alu_op_out <= "0001"; -- or
                elsif alu_op = "101" then
                    alu_op_out <= "0000"; -- and
                elsif alu_op = "010" then
                    alu_op_out <= "0011"; -- sub
                elsif alu_op = "011" then
                    alu_op_out <= "0101"; -- nor
                elsif alu_op = "100" then
                    alu_op_out <= "0100"; -- compara
                elsif alu_op = "000" then -- outros
                    if instruction_in = "000010" then -- SRL
                        alu_op_out <= "1000";
                    elsif instruction_in = "000011" then -- SRA
                        alu_op_out <= "1001";
                    elsif instruction_in = "000000" then -- SLL
                        alu_op_out <= "0111";
                    elsif instruction_in = "100000" then -- add
                        alu_op_out <= "0010";
                    elsif instruction_in = "100100" then -- and
                        alu_op_out <= "0000";
                    elsif instruction_in = "100101" then -- or
                        alu_op_out <= "0001";
                    elsif instruction_in = "100010" then -- sub
                        alu_op_out <= "0011";
                    elsif instruction_in = "100110" then -- xor
                        alu_op_out <= "0110";
                    elsif instruction_in = "101010" then -- slt
                        alu_op_out <= "0100";
                    elsif instruction_in = "001000" then -- jr
                        jr <= '1';
                    end if;



                end if;


    	end process;


end architecture;
