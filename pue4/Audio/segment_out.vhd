----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:03 07/06/2016 
-- Design Name: 
-- Module Name:    segment_out - Behavioral 
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

entity segment_out is port (
	clk		: in  STD_LOGIC;
	ready		: in  STD_LOGIC;
	reset		: in  STD_LOGIC;
	scancode	: in  STD_LOGIC_VECTOR(7 downto 0);
	segments	: out STD_LOGIC_VECTOR(14 downto 0));
end segment_out;

architecture Behavioral of segment_out is
	component seg_scancode_to_segments is port (
		scancode			: in  STD_LOGIC_VECTOR(7 downto 0);
		segment_repr	: out  STD_LOGIC_VECTOR(6 downto 0));
	end component;

	signal isE0, isF0, stw_q: STD_LOGIC;
	signal segment_repr : STD_LOGIC_VECTOR(6 downto 0);
	signal clock_divide_counter : Integer range 0 to 100000;
	signal current_digit : Integer range 0 to 7;

	signal	digit0 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit1 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit2 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit3 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit4 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit5 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit6 : STD_LOGIC_VECTOR (6 downto 0);
	signal	digit7 : STD_LOGIC_VECTOR (6 downto 0);
begin
	
	seg_scancode_to_segments0: seg_scancode_to_segments port map (scancode, segment_repr);
	
	ef0_detector : process(scancode)
	begin
		if(scancode = "11100000") then
			isE0 <= '1';
		else
			isE0 <= '0';
		end if;
		
		if(scancode = "11110000") then
			isF0 <= '1';
		else
			isF0 <= '0';
		end if;
	end process ef0_detector;
	
	stw : process (isE0, isF0, ready, clk)
	begin
		if clk'event and clk = '1' and ready = '1' then
				if stw_q = '0' then
					if isE0 = '0' AND isF0 = '0' then
						digit7 <= digit6;
						digit6 <= digit5;
						digit5 <= digit4;
						digit4 <= digit3;
						digit3 <= digit2;
						digit2 <= digit1;
						digit1 <= digit0;
						digit0 <= segment_repr;
					elsif isE0 = '0' AND isF0 = '1' then
						stw_q <= '1';
					end if;
				else
					stw_q <= '0';
				end if;
		end if;
	end process stw;
	
	digit_select_clock_divider : process(clk)
	begin
		if clk'event and clk = '1' then
			if clock_divide_counter >= 99999 then
				clock_divide_counter <= 0;
				current_digit <= current_digit + 1; -- overflows automatically with mod 8
			else
				clock_divide_counter <= clock_divide_counter + 1;
			end if;
		end if;
	end process digit_select_clock_divider;
	
	digit_time_multiplex : process (current_digit)
	begin
		if current_digit = 0 then
			segments <= "11111110" & digit0;
		elsif current_digit = 1 then
			segments <= "11111101" & digit1;
		elsif current_digit = 2 then
			segments <= "11111011" & digit2;
		elsif current_digit = 3 then
			segments <= "11110111" & digit3;
		elsif current_digit = 4 then
			segments <= "11101111" & digit4;
		elsif current_digit = 5 then
			segments <= "11011111" & digit5;
		elsif current_digit = 6 then
			segments <= "10111111" & digit6;
		else
			segments <= "01111111" & digit7;		
		end if;
	end process digit_time_multiplex;
	
end Behavioral;

