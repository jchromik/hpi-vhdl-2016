----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:37 07/08/2016 
-- Design Name: 
-- Module Name:    audio_out - Behavioral 
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

entity audio_out is port (
	clk		: in  STD_LOGIC;
	ready		: in  STD_LOGIC;
	reset		: in  STD_LOGIC;
	scancode	: in  STD_LOGIC_VECTOR(7 downto 0);
	audio		: out STD_LOGIC);
end audio_out;

architecture Behavioral of audio_out is

begin


end Behavioral;

