----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:59:04 06/12/2016 
-- Design Name: 
-- Module Name:    S_Reg - Behavioral 
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

entity S_Reg is
    Port ( c_V, c_R : STD_LOGIC; -- Taktflanken
           RESET : in  STD_LOGIC; -- asynchrones Reset
           S : in  STD_LOGIC_VECTOR (2 downto 1); -- Steuersignal(e)
           P : in  STD_LOGIC_VECTOR (3 downto 0); -- 4 Bits für Ladeoperation
           e_l : in  STD_LOGIC; -- einzuschiebendes Bit bei rechts schieben
           e_r : in  STD_LOGIC; -- einzuschiebendes Bit bei links schieben
           Q : buffer  STD_LOGIC_VECTOR (3 downto 0)); -- Zustand
end S_Reg;

architecture Behavioral of S_Reg is
signal D: STD_LOGIC_VECTOR(3 downto 0); -- Ausgang MUX, Eingang D-Register
signal c, Q_int, nQ_int: STD_LOGIC; -- für Taktentprellung
begin

	-- MUX: implementiert Steuerlogik
	mux: process(S,P,Q,e_l,e_r)
	begin
		case S is
			when "00" => D <= Q; -- halten
			when "01" => D <= Q(2 downto 0) & (not Q(3)); -- Möbius schieben, anstelle von links schieben
			when "10" => D <= e_l & Q(3 downto 1); -- rechts schieben
			when others => D <= P; -- laden
		end case;
	end process mux;

	-- D-Register: speichert Zustand, implementiert asynchrones Reset
	D_Reg: process(c,RESET)
	begin
		if RESET = '1' then
			Q <= "0000";
		elsif c'event and c = '1' then
			Q <= D;
		end if;
	end process D_Reg;
	
	-- Entprellung des Taktsignals wie im Skript Seite 66
	Q_int <= c_R nor nQ_int;
	nQ_int <= c_V nor Q_int;
	c <= Q_int;

end Behavioral;

