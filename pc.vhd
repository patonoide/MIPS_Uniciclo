library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;


entity pc is

	port(
		clk : in std_logic;
		entrada : in std_logic_vector (31 downto 0);

		saida : out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of pc is

begin
	process(clk)
	begin

			if(rising_edge(clk)) then
				saida <= entrada;
			end if;
		
	end process;

end architecture;
