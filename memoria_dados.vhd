library ieee;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity data_memory is
  port (

    write_enable : in std_logic;
    data_out : out std_logic_vector(31 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    address : in std_logic_vector(6 downto 0)
  );
end entity;

architecture  data_memory of data_memory is
    type mem is array ( 0 to 127) of std_logic_vector(31 downto 0);
       signal data_mem : mem := (
                                        x"00000000",
										x"00000000",
										x"00000000",
										x"00000000",
										x"00000000",
										others => (others => '0')
       );





begin
    principal : process(write_enable, data_in, address)
    begin

            if (write_enable = '1') then
                data_mem(to_integer(unsigned(address))) <= data_in;
            else
                data_out <= data_mem(to_integer(unsigned(address)));
            end if;



    end process;

end architecture;
