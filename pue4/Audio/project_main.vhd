----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:10:49 07/06/2016 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_main is port (
	clk		: in  STD_LOGIC;
	reset		: in  STD_LOGIC;
	kbclk		: in  STD_LOGIC;
	kbdata	: in  STD_LOGIC;
	leds		: out STD_LOGIC_VECTOR(7 downto 0);
	segments	: out STD_LOGIC_VECTOR(14 downto 0));
end project_main;

architecture Behavioral of project_main is
	component keyboard_in is port (
		clk		: in  STD_LOGIC;
		kbclk		: in  STD_LOGIC;
		kbdata	: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		ready		: out STD_LOGIC;
		scancode	: out STD_LOGIC_VECTOR(7 downto 0));
	end component;

	component led_out is port (
		clk		: in  STD_LOGIC;
		ready		: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		scancode	: in  STD_LOGIC_VECTOR(7 downto 0);
		leds		: out STD_LOGIC_VECTOR(7 downto 0);
		segments	: out STD_LOGIC_VECTOR(14 downto 0));
	end component;

	signal scancode: STD_LOGIC_VECTOR(7 downto 0);
	signal ready: STD_LOGIC;
begin
	
	keyboard_in0: keyboard_in port map (clk, kbclk, kbdata, reset, ready, scancode);
	led_out0: led_out port map (clk, ready, reset, scancode, leds, segments);
	
end Behavioral;

