----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:03:00 05/17/2016 
-- Design Name: 
-- Module Name:    pUe11 - Behavioral 
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

entity pUe11 is
    Port ( ax : in  STD_LOGIC_VECTOR (2 downto 1);
           ay : in  STD_LOGIC_VECTOR (2 downto 1);
           Xa : in  STD_LOGIC_VECTOR (4 downto 1);
           Ye : out  STD_LOGIC_VECTOR (4 downto 1));
end pUe11;

architecture Behavioral of pUe11 is
signal V : STD_LOGIC;
begin
	with ax select
		V <=	Xa(1) when "00",
				Xa(2) when "01",
				Xa(3) when "10",
				Xa(4) when others;
				
	with ay select
		Ye <=	"000"	&	V				when "00",
				"00"	&	V & "0"		when "01",
				"0"	&	V & "00"		when "10",
							V & "000"	when others;

end Behavioral;

