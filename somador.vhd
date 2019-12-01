library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity somador is
  port (
    number1 : in std_logic_vector(31 downto 0);
    number2 : in std_logic_vector(31 downto 0);
    saida : out std_logic_vector(31 downto 0)
  );
end entity;

architecture  somador of somador is
    signal temp : integer;
begin

        temp <= to_integer(unsigned(number1)) + to_integer(unsigned(number2));
        saida <= std_logic_vector(to_unsigned(temp, 32));
    

end architecture;
