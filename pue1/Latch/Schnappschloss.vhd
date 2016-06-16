-- Pegelgetaktetes D-FF mit Reset
-- Automatenebene, 2-Prozess-Variante 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PDFF_R_RK is
    Port ( c : in bit;
    		 D: in bit;
		 R: in bit;	-- Reset
		y: out bit; 
           ny : out bit
);
end PDFF_R_RK;

--
-- Reset via RK  ------------------------------------------------------------
--

architecture Automatenspek of PDFF_R_RK is

	type Zustaende is (Za, Zb); -- Aufzhlungstyp
	signal Z, Z_folge : Zustaende;
	
	signal X : bit_vector (1 downto 0);
	signal yInt : bit;

begin

  -- Zustandsberfhrungs- und Ausgabefunktion

  	X <= (c,D);

	Delta: process (X,Z)
		begin
			case Z is
				when Za => 	yInt <= '0';
							if X = "11" then Z_folge <= Zb;
							else	Z_folge <= Za;
							end if;

				when Zb =>	yInt <= '1';
							if X = "10" then Z_folge <= Za;
							else Z_folge <= Zb;
							end if;
			end case;
	end process Delta;

		
  --	RK (direkte Rckfhrung):
	
	RK: process (Z_folge, R)
		begin
			if R = '1' then Z <= Za   ;
			else Z <= Z_folge;
			end if;
	end process RK;
	
	y <= yInt;
-- inv. Ausgang:
  ny <= not yInt;
	 		
end Automatenspek;