library ieee;
use ieee.std_logic_1164.all;

entity branch_control is
  port (
    clock : in std_logic;
    branch : in std_logic_vector(1 downto 0);
    zero : in std_logic;
    mux_in : out std_logic
  );
end entity;

architecture behavioral of branch_control is

begin


    	process( branch, zero, clock)
    		begin



                if branch = "01" and zero = '1' then -- beq
                    mux_in <= '1';
                elsif branch = "10" and zero = '0' then -- bne
                    mux_in <= '1';
                else
                    mux_in <= '0';
                end if;

                






    	end process;


end architecture;
