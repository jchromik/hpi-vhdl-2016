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
use IEEE.NUMERIC_STD;

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
	component audio_scancode_to_divisor is port (
		scancode			: in  STD_LOGIC_VECTOR(7 downto 0);
		clock_divisor	: out INTEGER);
	end component;

	type audio_clock_states is (HIGH, LOW);
	
	signal clock_divisor : INTEGER := 378788; -- for 264 Hz (c')
	signal clock_counter_max : INTEGER := 0;
	signal clock_counter : INTEGER := 0;
	signal audio_clock_state : audio_clock_states := LOW;
begin

	audio_scancode_to_divisor0 : audio_scancode_to_divisor port map (scancode, clock_divisor);

	clock_divider : process(clock_counter_max, clk)
	begin
		if clk'event and clk = '1' then
			if clock_counter >= clock_counter_max then
				clock_counter <= 0;
				if audio_clock_state <= LOW then
					audio_clock_state <= HIGH;
				else
					audio_clock_state <= LOW;
				end if;
			else
				clock_counter <= clock_counter + 1;
			end if;
		end if;
	end process clock_divider;
	
	divisor_to_max_counter : process(clock_divisor)
	begin
		-- 100 MHz divided by clock_divisor
		-- result divided again by 2 to achive alternating high and low with correct frequency
		clock_counter_max <= 100000000 / (clock_divisor * 2);
	end process divisor_to_max_counter;

end Behavioral;

