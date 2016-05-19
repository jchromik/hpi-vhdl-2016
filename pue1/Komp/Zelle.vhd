----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:34 05/19/2016 
-- Design Name: 
-- Module Name:    Zelle - Behavioral 
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

entity Zelle is port (
	Cin, Xi: in STD_LOGIC;
	Cout, Yi: out STD_LOGIC
);
end Zelle;



architecture Behavioral of Zelle is
signal
	buendel: std_logic_vector(1 downto 0);
begin
	buendel <= (Cin, Xi);
	with buendel select
		(Cout, Yi) <=	std_logic_vector'("00") when "00",
							std_logic_vector'("10") when "11",
							std_logic_vector'("11") when others;
end Behavioral;
