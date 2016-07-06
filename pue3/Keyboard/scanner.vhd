----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:14:44 07/06/2016 
-- Design Name: 
-- Module Name:    scanner - Behavioral 
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

entity scanner is
    Port ( clk : in  STD_LOGIC;
           rf : in  STD_LOGIC;
           kbdata : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ready : out  STD_LOGIC;
           scancode : out  STD_LOGIC_VECTOR(7 downto 0));
end scanner;

architecture Behavioral of scanner is
signal dscan: STD_LOGIC_VECTOR(10 downto 0) := "11111111111";
begin

	dscan_read: process(kbdata, clk, rf, dscan, reset)
	begin
		if reset = '1' then
		  dscan <= "11111111111";
		elsif clk'event and clk = '1' then
		   if dscan(0) = '0' then
				dscan <= "11111111111";
			end if;
			if rf = '1' then
				dscan <= kbdata & dscan(10 downto 1);
			end if;
		end if;
	end process dscan_read;
	
	scancode <= dscan(8 downto 1);
	ready <= not dscan(0);
end Behavioral;

