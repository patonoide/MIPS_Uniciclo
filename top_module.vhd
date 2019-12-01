library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;


entity Agora_vai is

	port(
		clk, reset : in std_logic;
		entrada : in std_logic_vector (31 downto 0);

		saida : out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of Agora_vai is

	component alu is
		port	(
					A, B: in std_logic_vector(31 downto 0);
					op: in std_logic_vector(3 downto 0);
					zero : out std_logic;
					negative : out std_logic;
					result: out std_logic_vector(31 downto 0)
				);
	end component;

	component pc is

		port(
			clk : in std_logic;
			entrada : in std_logic_vector (31 downto 0);

			saida : out std_logic_vector (31 downto 0)
		);
	end component;

	component controle is
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
  end component;

  component mux_32 is
    port (
      entrada0 : in std_logic_vector(31 downto 0);
      entrada1 : in std_logic_vector(31 downto 0);
      seletor : in std_logic;
      saida : out std_logic_vector(31 downto 0)

    );
   end component;

   component somador is
	 port (
	   number1 : in std_logic_vector(31 downto 0);
	   number2 : in std_logic_vector(31 downto 0);
	   saida : out std_logic_vector(31 downto 0)
	 );
   end component;

   component banco_reg is
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
  end component;

  component instruction_memory is
    port (
      clock : in std_logic;

      data_out : out std_logic_vector(31 downto 0);

      address : in std_logic_vector(31 downto 0)
    );
end component;

  component data_memory is
    port (
	  clock : in std_logic;
	  write_enable : in std_logic;
	  data_out : out std_logic_vector(31 downto 0);
	  data_in : in std_logic_vector(31 downto 0);
   	  address : in std_logic_vector(31 downto 0)
     );
  end component;

  component mux_5 is
    port (
      entrada0 : in std_logic_vector(5 downto 0);
      entrada1 : in std_logic_vector(5 downto 0);
      seletor : in std_logic;
      saida : out std_logic_vector(5 downto 0)

    );
   end component;

  component ula_control is
  port (
    instruction_in : in std_logic_vector(5 downto 0);
    alu_op : in std_logic_vector(3 downto 0);
    alu_op_out : out std_logic_vector(3 downto 0)
  );
 end component;

	signal mux0topc : std_logic_vector(31 downto 0);
	signal pctoinstructionadder : std_logic_vector(31 downto 0);
	signal somadorout : std_logic_vector(31 downto 0);
	signal instruction_memory_out : std_logic_vector(31 downto 0 );
	signal regdsttomux : std_logic;
	signal mux0_5_out : std_logic_vector(5 downto 0);
	signal mux0_32_out : std_logic_vector(31 downto 0);
	signal banco_reg_output1_out : std_logic_vector(31 downto 0);
	signal banco_reg_output2_out : std_logic_vector(31 downto 0);
	signal data_out_reg : std_logic_vector(31 downto 0);
	signal regwrite_out : std_logic;
	signal extented_instruction : std_logic_vector(32 downto 0);
	signal alu_src_out : std_logic;
	signal alu_op_out : std_logic_vector(3 downto 0);
	signal alu_zero_out : std_logic;
	signal alu_negative_out : std_logic;
	signal alu_result_out : std_logic_vector(31 downto 0);
	signal data_memory_out : std_logic_vector(31 downto 0);
	signal control_mem_to_reg : std_logic; -- saida controle



begin

	pc0 : pc port map (clk => clk , entrada => mux0topc, saida => pctoinstructionadder );

	somador4 : somador port map (number1 => pctoinstructionadder, number2 => X"00000004", saida => somadorout);

	instructions : instruction_memory port map(clock => clk , address => pctoinstructionadder, data_out => instruction_memory_out);

	--unidade_controle : controle port map ()
	--mux 0 é o mux na entrada do banco de registradores
	mux0_5 : mux_5 port map (entrada0 => instruction_memory_out(20 downto 16) , entrada1 => instruction_memory_out(15 downto 11), seletor=>regdsttomux ,saida => mux0_5_out);

	bank : banco_reg port map (clock => clk,
	 						   address1 => instruction_memory_out(25 downto 21),
							   address2 => instruction_memory_out(20 downto 16),
							   write_address => mux0_5_out,
							   output1 => banco_reg_output1_out,
							   output2 => banco_reg_output2_out,
							   write_data => data_out_reg,
							   write_enable => regwrite_out);

	--mux saida banco de registradores
	mux0_32 : mux_32 port map (entrada0 => banco_reg_output2_out, entrada1 => extented_instruction, seletor => alu_src_out, saida => mux0_32_out);

	alu0 : alu port map (A => banco_reg_output1_out, B => mux0_32_out, op => alu_op_out, zero => alu_zero_out , negative => alu_negative_out, result => alu_result_out );

	alu_control : ula_control port map (instruction_in => instruction_memory_out(5 downto 0) , alu_op => , alu_op_out => alu_op_out);

	memoria_de_dados : data_memory port map(address => alu_result_out ,data_in => banco_reg_output2_out , data_out => data_memory_out ,write_enable => , clock => clk );

	mux1_32 : mux32 port map (entrada0 => alu_result_out , entrada1 => data_memory_out , seletor => control_mem_to_reg , saida => data_out_reg);

	controle : controle port map (instruction => instruction_memory_out(5 downto 0), regdst => ,jump => , )

end architecture;
