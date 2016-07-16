library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity project_main is
    Port ( video: out  STD_LOGIC_VECTOR(11 downto 0);
           hsync: out  STD_LOGIC;
           vsync: out  STD_LOGIC;
		   segments: out STD_LOGIC_VECTOR(14 downto 0);
		   
		   clk: in STD_LOGIC;
		   kbclk: in STD_LOGIC;
		   kbdata: in STD_LOGIC;
		   reset: in STD_LOGIC;
		   
		   program_select: in STD_LOGIC;
		   
		   dbg: out STD_LOGIC);
end project_main;

architecture Behavioral of project_main is
	component video_timing is port(
		clk: in STD_LOGIC;

		x: out integer range 0 to 1440-1;
		y: out integer range 0 to 900-1;
		hsync: out  std_logic;
		vsync: out  std_logic;
		video_enable: out std_logic;
		logic_enable: out std_logic);
	end component;
	
	component keyboard_in is port (
		clk		: in  STD_LOGIC;
		kbclk		: in  STD_LOGIC;
		kbdata	: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		ready		: out STD_LOGIC;
		scancode	: out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component segment_out is port (
		clk		: in  STD_LOGIC;
		ready		: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		scancode	: in  STD_LOGIC_VECTOR(7 downto 0);
		segments	: out STD_LOGIC_VECTOR(14 downto 0);
		anyKeyDown	: out	STD_LOGIC);
	end component;
	
	component twister_logic is port(
		clk: in std_logic;
		key_down: in std_logic;	
		enable: in std_logic;
		
		color: buffer integer range 0 to 3);
	end component;

	component twister_output is port(
		clk: in std_logic;		
		color: in integer range 0 to 3;
		
		video: out std_logic_vector(11 downto 0));
	end component;

	component flappy_logic is port (
		clk: in  std_logic;
		enable: in  std_logic;
		key_down: in std_logic;
		random: in std_logic_vector(3 downto 0);
		
		bird_y: buffer integer range 0 to 900-1 := 300;
		obstacles: buffer std_logic_vector(15 downto 0);
		offset: buffer integer range 0 to 358;
		game_over: buffer std_logic := '1');
	end component;

	component flappy_output is port(
		clk : in std_logic;
		x : in integer range 0 to 1440-1;
		y : in integer range 0 to 900-1;
		bird_y : in integer range 0 to 900-1;
		obstacles: in std_logic_vector(15 downto 0);
		offset: in integer range 0 to 358;
		game_over: in std_logic;
		
		video : out std_logic_vector (11 downto 0));
	end component;

	component random_generator is port (
		clk: in  std_logic;
		key_down: in std_logic;
		random: buffer std_logic_vector(3 downto 0));
	end component;

	
	signal ready : STD_LOGIC;
	signal scancode: STD_LOGIC_VECTOR(7 downto 0);
	
	signal key_down: std_logic;
	
	signal video_enable: std_logic;
	signal logic_enable: std_logic;
	signal twister_color: integer range 0 to 3;
	signal twister_video: std_logic_vector(11 downto 0);
	
	signal flappy_bird_y: integer range 0 to 900-1;
	signal flappy_obstacles: std_logic_vector(15 downto 0);
	signal flappy_offset: integer range 0 to 358;
	signal flappy_game_over: std_logic;
	signal flappy_video: std_logic_vector(11 downto 0);
	signal random: std_logic_vector(3 downto 0);
	
	signal x: integer range 0 to 1440-1;
	signal y: integer range 0 to 900-1;
begin
	keyboard_in0: keyboard_in port map (clk, kbclk, kbdata, reset, ready, scancode);
	segment_out0: segment_out port map (clk, ready, reset, scancode, segments, key_down);
	
	vt: video_timing port map (clk, x, y, hsync, vsync, video_enable, logic_enable);
	
	tl: twister_logic port map (clk, key_down, logic_enable, twister_color);
	tp: twister_output port map (clk, twister_color, twister_video);
	
	fl: flappy_logic port map (clk, logic_enable, key_down, random, flappy_bird_y, flappy_obstacles, flappy_offset, flappy_game_over);
	fp: flappy_output port map (clk, x, y, flappy_bird_y, flappy_obstacles, flappy_offset, flappy_game_over, flappy_video);
	
	rg: random_generator port map (clk, key_down, random);
	
	process(clk)
	begin
		if clk'event and clk = '1' then
			if video_enable = '1' then
				if program_select = '1' then
					video <= twister_video;
				else
					video <= flappy_video;
				end if;
			else
				video <= "000000000000";
			end if;
		end if;
	end process;
	
	dbg <= key_down;
	
end Behavioral;

