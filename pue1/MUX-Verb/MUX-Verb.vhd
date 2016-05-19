----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:46:00 05/17/2016 
-- Design Name: 
-- Module Name:    MUX-Verb - Behavioral 
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

entity MUX-Verb is
    Port ( ax : in  STD_LOGIC_VECTOR (2 downto 1);
           ay : in  STD_LOGIC_VECTOR (2 downto 1);
           Xa : in  STD_LOGIC_VECTOR (4 downto 1);
           Ye : out  STD_LOGIC_VECTOR (4 downto 1));
end MUX-Verb;

architecture Behavioral of MUX-Verb is

begin


end Behavioral;

