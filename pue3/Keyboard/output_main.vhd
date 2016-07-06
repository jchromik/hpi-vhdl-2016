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
           segment_out : out  STD_LOGIC);
end output_main;

architecture Behavioral of output_main is
signal isE0, isF0: STD_LOGIC;
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
	
	led_out_pipe: process(isE0, isF0, ready, scancode)
	begin
		if (not (isE0 = '1' and isF0 = '1')) and ready = '1' then
			led_out <= scancode;
		end if; 
	end process led_out_pipe;
	
end Behavioral;

