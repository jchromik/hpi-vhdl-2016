----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:44 07/06/2016 
-- Design Name: 
-- Module Name:    keyboard_in - Behavioral 
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

entity keyboard_in is port(
	clk		: in  STD_LOGIC;
	kbclk		: in  STD_LOGIC;
	kbdata	: in  STD_LOGIC;
	reset		: in  STD_LOGIC;
	ready		: out STD_LOGIC;
	scancode	: out STD_LOGIC_VECTOR(7 downto 0));
end keyboard_in;

architecture Behavioral of keyboard_in is
	component kb_rf_fetch is port (
		kbclk	: in  STD_LOGIC;
		reset	: in  STD_LOGIC;
		clk	: in  STD_LOGIC;
		rf		: out STD_LOGIC);
	end component;
	
	component kb_scanner is port (
		clk		: in  STD_LOGIC;
		kbdata	: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		rf			: in  STD_LOGIC;
		ready		: out STD_LOGIC;
		scancode	: out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	signal rf: STD_LOGIC;
begin
	kb_rf_fetch0: kb_rf_fetch port map (kbclk, reset, clk, rf);
	kb_scanner0 : kb_scanner port map (clk, kbdata, reset, rf, ready, scancode);
end Behavioral;

