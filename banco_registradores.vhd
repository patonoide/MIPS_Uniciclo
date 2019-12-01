library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity banco_reg is
  port (
    clock : in std_logic;
    address1 : in std_logic_vector(5 downto 0);
    address2 : in std_logic_vector(5 downto 0);
    write_address : in std_logic_vector(5 downto 0);
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
          1=> "00000000000000000000000000000000",
          2=> "00000000000000000000000000000000",
          3=> "00000000000000000000000000000000",
          4=> "00000000000000000000000000000000",
          5=> "00000000000000000000000000000000",
          6=> "00000000000000000000000000000000",
          7=> "00000000000000000000000000000000",
          8=> "00000000000000000000000000000000",
          9=> "00000000000000000000000000000000",
          10=> "00000000000000000000000000000000",
          11=> "00000000000000000000000000000000",
          12=> "00000000000000000000000000000000",
          13=> "00000000000000000000000000000000",
          14=> "00000000000000000000000000000000",
          15=> "00000000000000000000000000000000",
          16=> "00000000000000000000000000000000",
          17=> "00000000000000000000000000000000",
          18=> "00000000000000000000000000000000",
          19=> "00000000000000000000000000000000",
          20=> "00000000000000000000000000000000",
          21=> "00000000000000000000000000000000",
          22=> "00000000000000000000000000000000",
          23=> "00000000000000000000000000000000",
          24=> "00000000000000000000000000000000",
          25=> "00000000000000000000000000000000",
          26=> "00000000000000000000000000000000",
          27=> "00000000000000000000000000000000",
          28=> "00000000000000000000000000000000",
          29=> "00000000000000000000000000000000",
          30=> "00000000000000000000000000000000",
          31=> "00000000000000000000000000000000"
          );




begin
    processo : process(clock)
    begin
        if address1 = "00000" then
            output1 <= "00000000000000000000000000000000";
        elsif address2 = "00000" then
            output2 <= "00000000000000000000000000000000";
        else
            if rising_edge(clock) and write_enable = '1' then
                data_mem(to_integer(unsigned(write_address))) <= write_data;
            else
                output1 <= data_mem(to_integer(unsigned(address1)));
                output2 <= data_mem(to_integer(unsigned(address2)));
            end if;
        end if;

    end process;

end architecture;
