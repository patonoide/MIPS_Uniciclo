library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity mux_5 is
  port (
    entrada0 : in std_logic_vector(4 downto 0);
    entrada1 : in std_logic_vector(4 downto 0);
    seletor : in std_logic;
    saida : out std_logic_vector(4 downto 0)

  );
end entity;

architecture  mux_5 of mux_5 is

begin

    saida <= entrada0 when (seletor = '0') else
             entrada1 when (seletor = '1');

end architecture;
