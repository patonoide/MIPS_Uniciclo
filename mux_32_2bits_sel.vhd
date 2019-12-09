library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity mux_32_2sel is
  port (
    entrada0 : in std_logic_vector(31 downto 0);
    entrada1 : in std_logic_vector(31 downto 0);
    entrada2 : in std_logic_vector(31 downto 0);
    entrada3 : in std_logic_vector(31 downto 0);
    seletor : in std_logic_vector(1 downto 0);
    saida : out std_logic_vector(31 downto 0)

  );
end entity;

architecture  mux_32_2sel of mux_32_2sel is

begin

    saida <= entrada0 when (seletor = "00") else
             entrada1 when (seletor = "01") else
             entrada2 when (seletor = "10") else
             entrada3 when (seletor = "11");

end architecture;
