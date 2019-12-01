library ieee;
use ieee.std_logic_1164.all;

entity controle is
  port (
    instruction : in std_logic_vector(5 downto 0);
    regdst : out std_logic;
    jump : out std_logic;
    branch : out std_logic;
    memread : out std_logic;
    memtoreg : out std_logic;
    aluop : out std_logic_vector(3 downto 0);
    memwrite : out std_logic;
    alusrc : out std_logic;
    regwrite : out std_logic

  );
end entity;

architecture  controle of controle is

    

begin

end architecture;
