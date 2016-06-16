----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:39 06/13/2016 
-- Design Name: 
-- Module Name:    VDFF - Automat 
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
use IEEE.std_logic_1164.all;

-- vorderflankengetaktetes D-FF, D-Wechsel bei c+ wird NICHT registriert (ALT)
-- Automatenebene
-- Simulation: ok
-- Schaltung: nicht ok (ISE kann keine async. Schaltungen entwerfen)
 
entity VDFF is
    Port ( R : in std_logic; 
           c : in std_logic; 
           Q : out std_logic;
		   nQ: out std_logic;
           dummy : out std_logic);
end VDFF;

architecture Automat of VDFF is
	signal Z: std_logic := '0';
begin

	dummy <= c;
	
  -- Zustandsberfhrungsfunktion (siehe Automat aus Lsung 7)
	Delta: process (c,Z)
	begin
		if R = '1' then
			Z <= '0';
		elsif c'event and c = '1' then
			Z <= not Z;
		end if;
	end process Delta; 

	-- Y auf Ausgabe-Port legen
	Q <= Z;
	nQ <= not Z;
end Automat;
