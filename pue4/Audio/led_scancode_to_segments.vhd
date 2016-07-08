----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:31 07/07/2016 
-- Design Name: 
-- Module Name:    led_scancode_to_segments - Behavioral 
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

entity led_scancode_to_segments is port (
	scancode 		: in  STD_LOGIC_VECTOR(7 downto 0);
	segment_repr	: out  STD_LOGIC_VECTOR(6 downto 0));
end led_scancode_to_segments;

architecture Behavioral of led_scancode_to_segments is
begin

	process(scancode)
	begin
		case scancode is
			when "00010110" => segment_repr <= "1001111"; --1
			when "00011110" => segment_repr <= "0010010"; --2
			when "00100110" => segment_repr <= "0000110"; --3
			when "00100101" => segment_repr <= "1001100"; --4
			when "00101110" => segment_repr <= "0100100"; --5
			when "00110110" => segment_repr <= "0100000"; --6
			when "00111101" => segment_repr <= "0001111"; --7
			when "00111110" => segment_repr <= "0000000"; --8
			when "01000110" => segment_repr <= "0000100"; --9
			when "01000101" => segment_repr <= "0000001"; --0
			
			when "00011100" => segment_repr <= "0001000"; --A
			when "00110010" => segment_repr <= "1100000"; --b
			when "00100001" => segment_repr <= "0110001"; --c
			when "00100011" => segment_repr <= "1000010"; --d
			when "00100100" => segment_repr <= "0110000"; --E
			when "00101011" => segment_repr <= "0111000"; --F
			when others => segment_repr <= "1000001"; --u;
		end case;
	end process;

end Behavioral;

