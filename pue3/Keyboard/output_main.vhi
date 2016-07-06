
-- VHDL Instantiation Created from source file output_main.vhd -- 15:02:44 07/06/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT output_main
	PORT(
		scancode : IN std_logic_vector(7 downto 0);
		ready : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		led_out : OUT std_logic_vector(7 downto 0);
		segment_out : OUT std_logic
		);
	END COMPONENT;

	Inst_output_main: output_main PORT MAP(
		scancode => ,
		ready => ,
		reset => ,
		clk => ,
		led_out => ,
		segment_out => 
	);


