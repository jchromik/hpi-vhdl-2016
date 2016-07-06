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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_main is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           kbclk : in  STD_LOGIC;
           kbdata : in  STD_LOGIC;
           led_out : out  STD_LOGIC_VECTOR(7 downto 0);
			  segment_out: out  STD_LOGIC_VECTOR(11 downto 0));
end project_main;

architecture Behavioral of project_main is
component keyboard_main is port (
	scancode : out  STD_LOGIC_VECTOR(7 downto 0);
	ready : out  STD_LOGIC;
	kbclk : in  STD_LOGIC;
	kbdata : in  STD_LOGIC;
	reset : in STD_LOGIC;
	clk : in STD_LOGIC);
end component;
component output_main is port (
	scancode : in  STD_LOGIC_VECTOR(7 downto 0);
   ready : in  STD_LOGIC;
   reset : in  STD_LOGIC;
   clk : in  STD_LOGIC;
   led_out : out  STD_LOGIC_VECTOR(7 downto 0);
   segment_out : out  STD_LOGIC_VECTOR(11 downto 0));
end component;
signal scancode: STD_LOGIC_VECTOR(7 downto 0);
signal ready: STD_LOGIC;
begin
 keyboard0: keyboard_main port map (scancode, ready, kbclk, kbdata, reset, clk);
 output0: output_main port map (scancode, ready, reset, clk, led_out, segment_out);

end Behavioral;

