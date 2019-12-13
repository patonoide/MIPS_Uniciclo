library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity banco_reg is
  port (
    clock : in std_logic;
    address1 : in std_logic_vector(4 downto 0);
    address2 : in std_logic_vector(4 downto 0);
    write_address : in std_logic_vector(4 downto 0);
    output1 : out std_logic_vector(31 downto 0);
    output2 : out std_logic_vector(31 downto 0);
    write_data : in std_logic_vector(31 downto 0);
    write_enable : in std_logic

  );
end entity;

architecture  banco_reg of banco_reg is


  type mem is array ( 0 to 31) of std_logic_vector(31 downto 0);
          signal data_mem : mem := (
          0=> "00000000000000000000000000000000",
           others => (others => '0')
          );




begin
    processo : process(clock)
    begin
        if address1 = "00000" then
            output1 <= "00000000000000000000000000000000";
        elsif address2 = "00000" then
            output2 <= "00000000000000000000000000000000";

        end if;
        if falling_edge(clock) and write_enable = '1' then
            data_mem(to_integer(unsigned(write_address))) <= write_data;


        end if;
        output1 <= data_mem(to_integer(unsigned(address1)));
        output2 <= data_mem(to_integer(unsigned(address2)));

    end process;

end architecture;
