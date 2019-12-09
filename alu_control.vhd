library ieee;
use ieee.std_logic_1164.all;

entity ula_control is
  port (
    instruction_in : in std_logic_vector(5 downto 0);
    alu_op : in std_logic_vector(2 downto 0);
    alu_op_out : out std_logic_vector(3 downto 0)
  );
end entity;

architecture behavioral of ula_control is

begin


    	process( instruction_in, alu_op)
    		begin
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
                elsif alu_op = "000" then
                    if instruction_in = "000010" then -- SRL
                        alu_op_out <= "1000";
                    elsif instruction_in = "000000" then -- SLL
                        alu_op_out <= "0111";
                    end if;



                end if;


    	end process;


end architecture;
