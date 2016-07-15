----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:40 07/13/2016 
-- Design Name: 
-- Module Name:    video_out - Behavioral 
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

entity video_out is
	Port ( red: out  STD_LOGIC_VECTOR(3 downto 0);
           green: out  STD_LOGIC_VECTOR(3 downto 0);
           blue: out  STD_LOGIC_VECTOR(3 downto 0);
           hsync: out  STD_LOGIC;
           vsync: out  STD_LOGIC;
		   
		   clk: in STD_LOGIC;
		   color: in integer range 0 to 3);
end video_out;

architecture Behavioral of video_out is
signal hcount: integer range 0 to 1904;
signal vcount: integer range 0 to 932;
begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if hcount = 1903 then
				hcount <= 0;
				if vcount = 931 then
					vcount <= 0;
				else
					vcount <= vcount + 1;
				end if;
			else
				hcount <= hcount + 1;
			end if;
	
			if vcount < (900 + 1) or vcount >= (900 + 1 + 3) then  --vcount < (768 + 4) or vcount >= (768 + 4 + 58) then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
			
			if hcount < (1440 + 80) or hcount >= (1440 + 80 + 152) then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
			
			if vcount < 900 and hcount < 1440 then
				case color is
					when 0 =>
						red <= "0000";
						green <= "0000";
						blue <= "1111";
					when 1 =>
						red <= "0000";
						green <= "1111";
						blue <= "0000";
					when 2 =>
						red <= "1111";
						green <= "1111";
						blue <= "0000";
					when 3 =>
						red <= "1111";
						green <= "0000";
						blue <= "0000";
				end case;
			else
				red <= "0000";
				green <= "0000";
				blue <= "0000";
			end if;
		end if;
	end process;

end Behavioral;

