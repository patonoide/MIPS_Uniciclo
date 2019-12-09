library ieee;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity instruction_memory is
  port (
    clock : in std_logic;

    data_out : out std_logic_vector(31 downto 0);

    address : in std_logic_vector(6 downto 0)
  );
end entity;

architecture  instruction_memory of instruction_memory is
    type mem is array ( 0 to 127) of std_logic_vector(31 downto 0);
       signal data_mem : mem := (
                                       x"abababab",
                                       x"efefefef",
                                       x"02146545",
                                       x"85781546",
                                       x"69782314",
                                       x"25459789",
                                       x"245a65c5",
                                       x"ac5b4b5b",
                                       x"ebebebeb",
                                       x"cacacaca",
                                       x"ecececec",
                                       x"facfcafc",
                                       x"ecaecaaa",
                                       x"dadadeac",
                                       others => (others => '1')
       );





begin
    principal : process(clock)
    begin
        if rising_edge(clock) then
                data_out <= data_mem(to_integer(unsigned(address)));
        end if;
    end process;

end architecture;
