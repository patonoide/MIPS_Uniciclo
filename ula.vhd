library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port	(
				A, B: in std_logic_vector(31 downto 0);
				op: in std_logic_vector(3 downto 0);
				zero : out std_logic;
				negative : out std_logic;
				result: out std_logic_vector(31 downto 0)
			);
end alu;

architecture behavioral of alu is
begin


	processo : process(A,B,op)
		variable resultado : std_logic_vector(31 downto 0);
 	begin
		case op is
			when "0000" => resultado := a and b;
			when "0001" => resultado := a or b;
			when "0010" => resultado := std_logic_vector(signed(A)+signed(B));
			when "0011" => resultado := std_logic_vector(signed(A)-signed(B));
			when "0100" =>
				if(signed(a) < signed(b)) then
					resultado := x"00000001";
				else resultado := (others => '0');
				end if;
			when "0101" => resultado := a nor b;
			when "0110" => resultado := a xor b;
			when "0111" => resultado := std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(A))));
			when "1000" => resultado := std_logic_vector(signed(B) srl to_integer(unsigned(A)));
			when "1001" => resultado := std_logic_vector(signed(B) srl to_integer(unsigned(A)));
		end case;

		if resultado = x"00000000" then
			zero <= '1';
		else
			zero <= '0';
		end if;

		if resultado <= x"80000000" then
			negative <= '1';
		else
			negative <= '0';
		end if;



		result <= resultado;
	end process;

end architecture behavioral;
