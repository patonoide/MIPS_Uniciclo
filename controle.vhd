library ieee;
use ieee.std_logic_1164.all;

entity controle is
  port (
    clk : in std_logic;
    instruction : in std_logic_vector(5 downto 0);
    regdst : out std_logic;
    jump : out std_logic;
    branch : out std_logic;
    memread : out std_logic;
    memtoreg : out std_logic;
    aluop : out std_logic_vector(2 downto 0);
    memwrite : out std_logic;
    alusrc : out std_logic;
    regwrite : out std_logic

  );
end entity;

architecture  controle of controle is

    begin

	process(clk, instruction)
		begin
		if rising_edge(clk) then
			case instruction is

				when "100011" => -- LW
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '1';
					regwrite <= '1';
					memread <= '1';
					memwrite <= '0';
					branch <= '0';
					aluop <= "110";
                    jump <= '0';

				when "101011" => -- SW
					regdst <= '0'; -- X
					alusrc <= '1';
					memtoreg <= '0'; -- X
					regwrite <= '0';
					memread <= '0';
					memwrite <= '1';
					branch <= '0';
					aluop <= "110";
                    jump <= '0';



                when "100000" => -- ADD
    				regdst <= '1';
    				alusrc <= '0';
    				memtoreg <= '0';
    				regwrite <= '1';
    				memread <= '0';
    				memwrite <= '0';
    				branch <= '0';
    				aluop <= "110";
                    jump <= '0';


				when "001000" => -- ADDI
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '0';
					regwrite <= '1';
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "110";
                    jump <= '0';

                when "000000" =>  -- SLL
                    regdst <= '1';
                    alusrc <= '1';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "000"; -- others no alu control
                    jump <= '0';

                when "000010" => -- SRL
                    regdst <= '1';
                    alusrc <= '1';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "000"; --  others no alu control
                    jump <= '0';

                when "101010" => -- SLT
                    regdst <= '1';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "100";
                    jump <= '0';

                when "001010" => -- SLTI
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '0';
					regwrite <= '1';
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "100";
                    jump <= '0';

                when "000100" => -- BEQ
                    regdst <= '0'; -- X
                    alusrc <= '0';
                    memtoreg <= 'X'; -- X
                    regwrite <= '0'; -- X
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '1';
                    aluop <= "010";
                    jump <= '0';

				when "000101" => -- BNE
					regdst <= '0'; -- X
					alusrc <= '0';
					memtoreg <= 'X'; -- X
					regwrite <= '0'; -- X
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "010";
                    jump <= '0';


                when "000010" => -- J
                    regdst <= '0';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "010";
                    jump <= '1';

                when "001000" => -- JR

                when "000011" => -- JAL

                when "100010" => -- SUB
                    regdst <= '0';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "010";
                    jump <= '0';

                when "100100" => -- AND
                    regdst <= '0';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "101";
                    jump <= '0';

				when "001100" => -- ANDI
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '0';
					regwrite <= '1';
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "101";
                    jump <= '0';

                when "100111" => -- NOR
                    regdst <= '0';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "011";
                    jump <= '0';


                when "100101" => -- OR
                    regdst <= '0';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "001";
                    jump <= '0';

				when "001101" => -- ORI
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '0';
					regwrite <= '1';
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "001";
                    jump <= '0';

                when "100110" => -- XOR
                    regdst <= '1';
                    alusrc <= '0';
                    memtoreg <= '0';
                    regwrite <= '1';
                    memread <= '0';
                    memwrite <= '0';
                    branch <= '0';
                    aluop <= "111";
                    jump <= '0';

				when "001110" => -- XORI
					regdst <= '0';
					alusrc <= '1';
					memtoreg <= '0';
					regwrite <= '1';
					memread <= '0';
					memwrite <= '0';
					branch <= '0';
					aluop <= "111";
                    jump <= '0';

			end case;
		end if;
	end process;

end architecture;
