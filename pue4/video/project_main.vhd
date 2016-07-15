----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:24 07/11/2016 
-- Design Name: 
-- Module Name:    project_main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_main is
    Port ( red: out  STD_LOGIC_VECTOR(3 downto 0);
           green: out  STD_LOGIC_VECTOR(3 downto 0);
           blue: out  STD_LOGIC_VECTOR(3 downto 0);
           hsync: out  STD_LOGIC;
           vsync: out  STD_LOGIC;
		   segments: out STD_LOGIC_VECTOR(14 downto 0);
		   
		   clk: in STD_LOGIC;
		   kbclk: in STD_LOGIC;
		   kbdata: in STD_LOGIC;
		   reset: in STD_LOGIC;
		   
		   dbg: out STD_LOGIC);
end project_main;

architecture Behavioral of project_main is
	component video_out is port (
		red: out  STD_LOGIC_VECTOR(3 downto 0);
		green: out  STD_LOGIC_VECTOR(3 downto 0);
		blue: out  STD_LOGIC_VECTOR(3 downto 0);
		hsync: out  STD_LOGIC;
		vsync: out  STD_LOGIC;
		
		clk: in STD_LOGIC;
		color: in integer range 0 to 3);
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
	
	signal ready : STD_LOGIC;
	signal scancode: STD_LOGIC_VECTOR(7 downto 0);
	signal color: integer range 0 to 3 := 0;
	
	signal color_counter: integer range 0 to 50000000 := 0;
	signal color_counter_max: integer range 0 to 50000000 := 50000000;
	
	signal key_down: std_logic;

begin
	keyboard_in0: keyboard_in port map (clk, kbclk, kbdata, reset, ready, scancode);
	segment_out0: segment_out port map (clk, ready, reset, scancode, segments,key_down);
	
	process(clk)
	begin
		if clk'event and clk = '1' then
			if color_counter = color_counter_max then
				color_counter <= 0;
				if key_down = '1' then
					if color_counter_max > 5000000 +10000000 then
						color_counter_max <= color_counter_max -10000000;
					else
						color_counter_max <= 5000000;
					end if;
				else
					if color_counter_max < 50000000 -2000000 then
						color_counter_max <= color_counter_max +2000000;
					else
						color_counter_max <= 50000000;
					end if;
				end if;
				
				if color_counter_max < 50000000 then
					if color = 3 then
						color <= 0;
					else
						color <= color + 1;
					end if;
				end if;
			else
				color_counter <= color_counter + 1;
			end if;
		end if;
		
		dbg <= key_down;
	end process;
	
	video_out0: video_out port map (red, green, blue, hsync, vsync, clk, color);
	

end Behavioral;

