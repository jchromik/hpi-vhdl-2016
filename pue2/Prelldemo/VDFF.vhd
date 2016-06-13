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
           Q : out std_logic := '0';
			  nQ: out std_logic := '1';
           dummy : out std_logic);
end VDFF;

architecture Automat of VDFF is
	type Zustaende is (Za, Zb, Zc, Zd); -- Aufzählungstyp
	signal Z, Z_folge : Zustaende;
	signal X : std_logic_vector (1 downto 0);	-- X = (c,D) 
	signal Y : std_logic_vector (1 downto 0);	-- Y = (Q, nQ)
	signal D : std_logic; -- neues internes Signal D (Teilaufgabe c))
begin
	X <= c & D;
	dummy <= D and c;

  -- Zustandsüberführungsfunktion (siehe Automat aus Lösung 7)
	Delta: process (X,Z)
	begin
		case Z is
			when Za =>
				if X = "01" then Z_folge <= Zb;
				else Z_folge <= Za;
				end if;
			when Zb =>
				if X = "01" then Z_folge <= Zb;
				elsif X = "00" then Z_folge <= Za;
				else Z_folge <= Zc;
				end if;
			when Zc => 
				if X = "00" then Z_folge <= Zd;
				else Z_folge <= Zc;
				end if;
			when Zd =>
				if X = "00" then Z_folge <= Zd;
				elsif X = "01" then Z_folge <= Zc;
				else Z_folge <= Za;
				end if;
		end case;
	end process Delta;

	-- Rückkopplungskomponente
	RK: process (Z_folge)
	begin
		if R = '1' then -- Reset-Signal (Teilaufgabe b))
			Z <= Za;
		else	
			Z <= Z_folge;
		end if;
	end process RK; 
	
	-- Ausgabefunktion
	u: process (Z)
		begin
			case Z is
				when Za => Y <= "01";
				when Zb => Y <= "01";
				when Zc => Y <= "10";
				when Zd => Y <= "10"; 
			end case;
	end process u;

	-- Y auf Ausgabe-Port legen
	Q <= Y(1);
	nQ <= Y(0);
	
	-- Rückkopplung von nQ (=Y(0)) auf D (Teilaufgabe c))
	D <= Y(0);
end Automat;
