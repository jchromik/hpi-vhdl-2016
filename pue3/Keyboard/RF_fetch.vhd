----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:33 07/06/2016 
-- Design Name: 
-- Module Name:    RF_fetch - Behavioral 
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

entity RF_fetch is
    Port ( kbclk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rf : out  STD_LOGIC);
end RF_fetch;

architecture Behavioral of RF_fetch is
signal clk_history: STD_LOGIC_VECTOR(1 downto 0);
begin
	
	clk_history_shift: process(kbclk, clk, reset)
	begin
		if reset = '1' then
			clk_history <= "11";
		elsif clk'event and clk = '1' then
			clk_history(1) <= clk_history(0);
			clk_history(0) <= kbclk;
		end if;
	end process clk_history_shift;
	
	find_rf: process(clk_history)
	begin
		if clk_history = "10" then
			rf <= '1';
		else
			rf <= '0';
		end if;
	end process find_rf;
	
end Behavioral;

