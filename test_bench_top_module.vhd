
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity mips_tb is


end mips_tb;

architecture topmodule_tb of mips_tb is

    component mips is

        port(
            clk : in std_logic

        );
    end component;

    component test_bench is

        port (
          clock : out std_logic

        );

    end component;

    signal clock_to_clk : std_logic;
begin

    mip0 : mips port map (clk => clock_to_clk);
    test0 : test_bench port map (clock => clock_to_clk);



end topmodule_tb ;
