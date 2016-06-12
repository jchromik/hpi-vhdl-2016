----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:33:53 06/12/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( OP_A : in  STD_LOGIC_VECTOR (3 downto 1);
           OP_B : in  STD_LOGIC_VECTOR (3 downto 1);
           O : in  STD_LOGIC_VECTOR (2 downto 1);
           Cein : in  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (4 downto 1));
end ALU;

architecture Behavioral of ALU is
signal Sum, Zw : STD_LOGIC_VECTOR(3 downto 1);
signal Caus, yu, yw : STD_LOGIC;
begin
	operate: process(OP_A,OP_B,O,Cein)
	begin
		Caus <= '0';
		Sum <= OP_A + OP_B;
		Zw <= (not OP_A) + "001"; -- TODO: Das ist nicht wie in Ü1A3, ist das schlimm?
		if OP_A = OP_B then yu <= '1'; else yu <= '0'; end if;
		if OP_A > OP_B then yw <= '1'; else yw <= '0'; end if;
		if Cein = '1' then
			Caus <= '1';
			case O is
				when "00" => R <= (Caus & Sum);
				when "01" => R <= ('0' & Zw);
				when others => R <= ("00" & yu & yw);
			end case;
		end if;
	end process operate;
end Behavioral;

