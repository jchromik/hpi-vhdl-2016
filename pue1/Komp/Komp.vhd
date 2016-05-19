----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:48:07 05/19/2016 
-- Design Name: 
-- Module Name:    Komp - Behavioral 
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

entity Komp is
    Port ( x : in  STD_LOGIC_VECTOR(5 downto 1);
           y : out  STD_LOGIC_VECTOR(5 downto 1));
end Komp;



architecture Behavioral of Komp is
component Zelle is port (
	Cin, Xi: in STD_LOGIC;
	Cout, Yi: out STD_LOGIC);
end component;

signal C1, C2, C3, C4, C5: std_logic;
begin
cell0: Zelle port map ('0', x(1), C1, y(1));
cell1: Zelle port map (C1, x(2), C2, y(2));
cell2: Zelle port map (C2, x(3), C3, y(3));
cell3: Zelle port map (C3, x(4), C4, y(4));
cell4: Zelle port map (C4, x(5), C5, y(5));

end Behavioral;

