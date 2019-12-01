library ieee;
use ieee.std_logic_1164.all;

entity ula_control is
  port (
    instruction_in : in std_logic_vector(5 downto 0);
    alu_op : in std_logic_vector(3 downto 0);
    alu_op_out : out std_logic_vector(3 downto 0)
  );
end entity;

architecture behavioral of ula_control is



begin



end architecture;
