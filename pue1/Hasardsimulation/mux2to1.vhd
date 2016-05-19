----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:11 05/18/2016 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
    --Port ( x1 : in  STD_LOGIC;
      --     x2 : in  STD_LOGIC;
        --   x3 : in  STD_LOGIC;
        --   y : out  STD_LOGIC);
				
	
end mux2to1;

architecture Behavioral of mux2to1 is

signal x1, x2, x3, y : STD_LOGIC;
signal x3v, x2v, x1v : STD_LOGIC;
signal b, c,e,d : STD_LOGIC;
begin
	x1 <= '1', '0' after 30ns;
	x2 <= '0', '1' after 30ns;
	x3 <= '1', '0' after 30ns;

	x3v <= transport(x3) after 0 ns;
	x2v <= transport(x2) after 3 ns;
	x1v <= transport(x1) after 6 ns;

	b <= transport(not x2v)	after 5ns;
	c <= transport(x2v and x1v)after 10 ns;
	e <= transport(x3v and x1v) after 10 ns;
	d <= transport(x3v and b) after 10 ns;
	y <= transport(c or e or d) after 10 ns;

end Behavioral;

