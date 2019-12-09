library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;


entity mips is

	port(
		clk : in std_logic

	);
end entity;

architecture rtl of mips is

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
       address1 : in std_logic_vector(4 downto 0);
       address2 : in std_logic_vector(4 downto 0);
       write_address : in std_logic_vector(4 downto 0);
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
      entrada0 : in std_logic_vector(4 downto 0);
      entrada1 : in std_logic_vector(4 downto 0);
      seletor : in std_logic;
      saida : out std_logic_vector(4 downto 0)

    );
   end component;


  component ula_control is
  	port (
    	instruction_in : in std_logic_vector(5 downto 0);
    	alu_op : in std_logic_vector(2 downto 0);
    	alu_op_out : out std_logic_vector(3 downto 0)
  	);
   end component;

	signal mux3_to_pc : std_logic_vector(31 downto 0);
	signal pc_to_instruction_adder : std_logic_vector(31 downto 0);
	signal somador_out : std_logic_vector(31 downto 0);
	signal instruction_memory_out : std_logic_vector(31 downto 0 );
	signal regdsttomux : std_logic;
	signal mux0_5_out : std_logic_vector(4 downto 0);
	signal mux0_32_out : std_logic_vector(31 downto 0);
	signal banco_reg_output1_out : std_logic_vector(31 downto 0);
	signal banco_reg_output2_out : std_logic_vector(31 downto 0);
	signal data_out_reg : std_logic_vector(31 downto 0);
	signal regwrite_out : std_logic;
	signal extented_instruction : std_logic_vector(31 downto 0);
	signal alu_src_out : std_logic;
	signal alu_op_out : std_logic_vector(3 downto 0);
	signal alu_zero_out : std_logic;
	signal alu_negative_out : std_logic;
	signal alu_result_out : std_logic_vector(31 downto 0);
	signal data_memory_out : std_logic_vector(31 downto 0);
	signal control_mem_to_reg : std_logic; -- saida controle
	signal control_jmp : std_logic;
	signal control_branch : std_logic;
	signal control_regdest : std_logic;
	signal control_memread : std_logic;
	signal control_alu_op : std_logic_vector(2 downto 0);
	signal control_memwrite : std_logic;
	signal control_alusrc : std_logic;
	signal control_reg_write : std_logic;
	signal branch_and_zero : std_logic;
	signal saida_mux2 : std_logic_vector(31 downto 0);
	signal somador2_out :std_logic_vector(31 downto 0);
	signal jump_adress_before_add : std_logic_vector(31 downto 0);
	signal jump_adress_after_add : std_logic_vector(31 downto 0);
	signal valor4 : std_logic_vector(31 downto 0);
	signal shift_left0 : std_logic_vector(31 downto 0);

begin

	valor4 <= "00000000000000000000000000000100";

	pc0 : pc port map (clk => clk , entrada => mux3_to_pc, saida => pc_to_instruction_adder );

	somador4 : somador port map (number1 => pc_to_instruction_adder, number2 => valor4, saida => somador_out);

	instructions : instruction_memory port map(clock => clk , address => pc_to_instruction_adder, data_out => instruction_memory_out);


	--mux 0 é o mux na entrada do banco de registradores
	mux0_5 : mux_5 port map (entrada0 => instruction_memory_out(20 downto 16) , entrada1 => instruction_memory_out(15 downto 11), seletor=>control_regdest ,saida => mux0_5_out);

	bank : banco_reg port map (clock => clk,
	 						   address1 => instruction_memory_out(25 downto 21),
							   address2 => instruction_memory_out(20 downto 16),
							   write_address => mux0_5_out,
							   output1 => banco_reg_output1_out,
							   output2 => banco_reg_output2_out,
							   write_data => data_out_reg,
							   write_enable => control_reg_write);

	--mux saida banco de registradores
	mux0_32 : mux_32 port map (entrada0 => banco_reg_output2_out, entrada1 => extented_instruction, seletor => control_alusrc, saida => mux0_32_out);

	alu0 : alu port map (A => banco_reg_output1_out, B => mux0_32_out, op => alu_op_out, zero => alu_zero_out , negative => alu_negative_out, result => alu_result_out );

	alu_control : ula_control port map (instruction_in => instruction_memory_out(5 downto 0) , alu_op => control_alu_op, alu_op_out => alu_op_out);

	memoria_de_dados : data_memory port map(address => alu_result_out ,data_in => banco_reg_output2_out , data_out => data_memory_out ,write_enable => control_memwrite, clock => clk );

	mux1_32 : mux_32 port map (entrada0 => alu_result_out , entrada1 => data_memory_out , seletor => control_mem_to_reg , saida => data_out_reg);

	controle0 : controle port map (clk => clk,
							      instruction => instruction_memory_out(5 downto 0),
	 							  regdst => control_regdest,
								  jump => control_jmp,
								  branch => control_branch,
								  memread => control_memread,
								  memtoreg=> control_mem_to_reg,
								  aluop => control_alu_op,
								  memwrite=> control_memwrite,
								  alusrc => control_alusrc,
								  regwrite => control_reg_write);

	 extented_instruction <= "0000000000000000" & instruction_memory_out(16 downto 0);

	 branch_and_zero <= control_branch and alu_zero_out;

	 jump_adress_before_add <= pc_to_instruction_adder(31 downto 28) & instruction_memory_out(26 downto 0) & "00";

	 shift_left0 <= extented_instruction(29 downto 0) & "00";

	 mux2_32 : mux_32 port map (entrada0 => somador_out , entrada1 => somador2_out , seletor => branch_and_zero , saida => saida_mux2 );

	 mux3_32 : mux_32 port map (entrada0 => saida_mux2 , entrada1 => jump_adress_after_add , seletor => control_jmp , saida => mux3_to_pc);

	 somador4_2 : somador port map (number1 => somador_out, number2 => shift_left0, saida => somador2_out ); -- somador antes do mux

	 somador4_3 : somador port map(number1 => jump_adress_before_add , number2 => valor4, saida => jump_adress_after_add);

end architecture;
