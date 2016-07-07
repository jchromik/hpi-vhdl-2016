----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:03 07/06/2016 
-- Design Name: 
-- Module Name:    output_main - Behavioral 
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

entity output_main is
    Port ( scancode : in  STD_LOGIC_VECTOR(7 downto 0);
           ready : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           led_out : out  STD_LOGIC_VECTOR(7 downto 0);
           segment_out : out  STD_LOGIC_VECTOR(14 downto 0));
end output_main;

architecture Behavioral of output_main is

component key2segments is port (
	scancode : in  STD_LOGIC_VECTOR(7 downto 0);
    segments : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

signal isE0, isF0, stw_q: STD_LOGIC;
signal segments : STD_LOGIC_VECTOR(6 downto 0);
signal mul_ctr : Integer range 0 to 100000;
signal cur_led : Integer range 0 to 7;

signal	led0 : STD_LOGIC_VECTOR (6 downto 0);
signal	led1 : STD_LOGIC_VECTOR (6 downto 0);
signal	led2 : STD_LOGIC_VECTOR (6 downto 0);
signal	led3 : STD_LOGIC_VECTOR (6 downto 0);
signal	led4 : STD_LOGIC_VECTOR (6 downto 0);
signal	led5 : STD_LOGIC_VECTOR (6 downto 0);
signal	led6 : STD_LOGIC_VECTOR (6 downto 0);
signal	led7 : STD_LOGIC_VECTOR (6 downto 0);

begin
	
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
	
	key2seg1: key2segments port map (scancode, segments);
	
	
	
	led_out_pipe: process(isE0, isF0, ready, scancode, clk, segments)
	begin
		if clk'event and clk = '1' and (not (isE0 = '1' or isF0 = '1')) and ready = '1' then
			led_out <= scancode;
		end if; 
	end process led_out_pipe;
	
	stw : process (isE0, isF0, ready, clk)
	begin
	
	if clk'event and clk = '1' and ready = '1' then
			if stw_q = '0' then
				if isE0 = '0' AND isF0 = '0' then
					led7 <= led6;
					led6 <= led5;
					led5 <= led4;
					led4 <= led3;
					led3 <= led2;
					led2 <= led1;
					led1 <= led0;
					led0 <= segments;
				elsif isE0 = '0' AND isF0 = '1' then
					stw_q <= '1';
				end if;
			else
				stw_q <= '0';
			end if;
	end if;
	end process stw;
	
	ctr : process(clk)
	begin
		if(clk'event and clk = '1') then
			if mul_ctr >= 99999 then
				mul_ctr <= 0;
				cur_led <= cur_led + 1;
			else
				mul_ctr <= mul_ctr + 1;
			end if;
				
		end if;
	end process ctr;
	
	multiplex : process (cur_led)
	begin
		if cur_led = 0 then
			segment_out <= "11111110" & led0;
		elsif cur_led = 1 then
			segment_out <= "11111101" & led1;
		elsif cur_led = 2 then
			segment_out <= "11111011" & led2;
		elsif cur_led = 3 then
			segment_out <= "11110111" & led3;
		elsif cur_led = 4 then
			segment_out <= "11101111" & led4;
		elsif cur_led = 5 then
			segment_out <= "11011111" & led5;
		elsif cur_led = 6 then
			segment_out <= "10111111" & led6;
		else
			segment_out <= "01111111" & led7;		
		end if;
	end process multiplex;
	
	
end Behavioral;

