
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity test_bench is

    port (
      clock : out std_logic;
      instruction : out std_logic_vector(5 downto 0);
      regdst : out std_logic;
      jump : out std_logic_vector(1 downto 0);
      branch : out  std_logic;
      memread : out std_logic;
      memtoreg : out std_logic;
      aluop : out std_logic_vector(2 downto 0);
      memwrite : out std_logic;
      alusrc : out std_logic;
      regwrite : out std_logic
    );

end test_bench;

architecture behavioral of test_bench is

    component mips is

    	port(
    		clk : in std_logic;
    		instruction : out std_logic_vector(5 downto 0);
    	    regdst : out std_logic;
    	    jump : out std_logic_vector(1 downto 0);
    	    branch : out std_logic;
    	    memread : out std_logic;
    	    memtoreg : out std_logic;
    	    aluop : out std_logic_vector(2 downto 0);
    	    memwrite : out std_logic;
    	    alusrc : out std_logic;
            reset_pc : in std_logic;
    	    regwrite : out std_logic
    	);
    end component;

    signal clock_real : std_logic;
    signal resetador_de_pc : std_logic;
begin
    clock <= clock_real;
    mip0 : mips port map (
                                 clk => clock_real,
                                 regdst => regdst,
                                 jump => jump,
                                 branch => branch,
                                 memread => memread,
                                 memtoreg => memtoreg,
                                 aluop => aluop,
                                 memwrite => memwrite,
                                 alusrc => alusrc,
                                 regwrite => regwrite,
                                 reset_pc => resetador_de_pc,
                                 instruction => instruction);




    process

        variable clock_v : std_logic;
        variable pc : std_logic;
    begin

        pc := '1';
        resetador_de_pc <= pc;
        wait for 1 ns;
        clock_v := '0';
        clock_real <= clock_v;
        wait for 1 ns;
        clock_v := '1';
        clock_real <= clock_v;
        wait for 1 ns;
        pc := '0';
        resetador_de_pc <= pc;

        for i in 0 to 20 loop
            wait for 10 ns;
            clock_v := '0';
            clock_real <= clock_v;

            wait for 10 ns;
            clock_v := '1';
            clock_real <= clock_v;

        end loop;
        report "deu bom" severity NOTE;


    end process;



end behavioral ;
