library ieee;
use ieee.std_logic_1164.all;

entity jump_mux_control is
  port (
    jr : in std_logic;
    jump_control : in std_logic_vector(1 downto 0);
    mux_control : out std_logic_vector(1 downto 0)
  );
end entity;

architecture behavioral of jump_mux_control is

begin


    	process( jr, jump_control)
    		begin
                if jr = '1' then
                    mux_control <= "10";
                else
                    if jump_control = "00" then
                        mux_control <= "00";
                    elsif jump_control = "01" then
                        mux_control <= "01";
                    elsif jump_control = "11" then
                        mux_control <= "11";
                    end if;
                end if;

    	end process;


end architecture;
