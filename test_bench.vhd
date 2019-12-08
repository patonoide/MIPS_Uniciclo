
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity test_bench is

    port (
      clock : out std_logic

    );

end test_bench;

architecture behavioral of test_bench is

begin
    process

        variable clock_v : std_logic;

    begin



        for i in 0 to 20 loop
            wait for 200 ns;
            clock_v := '0';
            clock <= clock_v;

            wait for 200 ns;
            clock_v := '1';
            clock <= clock_v;

        end loop;


    end process;



end behavioral ;
