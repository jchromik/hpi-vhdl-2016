----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:22 06/16/2016 
-- Design Name: 
-- Module Name:    Fanoe - Behavioral 
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

entity Fanoe is
    Port ( x : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           c_V : in  STD_LOGIC;
           c_R : in  STD_LOGIC;
           g_me : out  STD_LOGIC;
           y1_me : out  STD_LOGIC;
           y2_me : out  STD_LOGIC;
           g_mo : out  STD_LOGIC;
           y1_mo : out  STD_LOGIC;
           y2_mo : out  STD_LOGIC);
end Fanoe;

architecture Behavioral of Fanoe is
	type Zustaende_me is (S1_me, S2_me, S3_me); -- Aufzählungstyp
	type Zustaende_mo is (S1_mo, S2_mo, S3_mo, S4_mo, S5_mo, S6_mo, S7_mo);
	signal S_me, S_folge_me : Zustaende_me;
	signal S_mo, S_folge_mo : Zustaende_mo;
	signal Y_me, Y_mo : std_logic_vector (2 downto 0);
	signal Q_int, nQ_int: STD_LOGIC;
	signal x_sync: STD_LOGIC;
begin
	DFF_x_buffer: process (Q_int, x, Reset)
	begin
		if Reset = '1' then
			x_sync <= '0';
		elsif Q_int'event and Q_int = '1' then
			x_sync <= x;
		else 
			x_sync <= x_sync;
		end if;
	end process DFF_x_buffer;
	
	RSFF_clock: process (c_V, c_R)
	begin
		nQ_int <= c_V nor Q_int;
		Q_int <= c_R nor nQ_int;
	end process RSFF_clock;
	
	
	-- MEALY

	Delta_Lambda_me: process (x_sync,S_me)
	begin
		case S_me is
			when S1_me =>
				if x_sync = '0' then
					S_folge_me <= S1_me;
					Y_me <= "001" ;
				else
					S_folge_me <= S2_me;
					Y_me <= "--0" ;
				end if;
			when S2_me =>
				if x_sync = '0' then
					S_folge_me <= S1_me;
					Y_me <= "011" ;
				else
					S_folge_me <= S3_me;
					Y_me <= "--0" ;
				end if;
			when S3_me =>
				if x_sync = '0' then
					S_folge_me <= S1_me;
					Y_me <= "101" ;
				else
					S_folge_me <= S1_me;
					Y_me <= "111" ;
				end if;
		end case;
	end process Delta_Lambda_me;
	
	RK_me: process (Q_int, Reset)
	begin
		if Reset = '1' then
			S_me <= S1_me;
		elsif Q_int = '1' and Q_int'event then
			S_me <= S_folge_me;
		end if;
	end process RK_me;
	
	y2_me <= Y_me(2);
	y1_me <= Y_me(1);
	g_me <= Y_me(0);
	
	
	-- Moore
	
	Delta_mo: process(x_sync, S_mo)
	begin
		case S_mo is
			when S1_mo =>
				if x_sync = '0' then S_folge_mo <= S2_mo;
				else S_folge_mo <= S3_mo; end if;
			when S2_mo =>
				if x_sync = '0' then S_folge_mo <= S2_mo;
				else S_folge_mo <= S3_mo; end if;
			when S3_mo =>
				if x_sync = '0' then S_folge_mo <= S4_mo;
				else S_folge_mo <= S5_mo; end if;
			when S4_mo => 
				if x_sync = '0' then S_folge_mo <= S2_mo;
				else S_folge_mo <= S3_mo; end if;	
			when S5_mo =>
				if x_sync = '0' then S_folge_mo <= S6_mo;
				else S_folge_mo <= S7_mo; end if;
			when S6_mo =>
				if x_sync = '0' then S_folge_mo <= S2_mo;
				else S_folge_mo <= S3_mo; end if;
			when S7_mo =>
				if x_sync = '0' then S_folge_mo <= S2_mo;
				else S_folge_mo <= S3_mo; end if;
		end case;
	end process Delta_mo;
	
	RK_mo: process (Q_int, Reset)
	begin
		if Reset = '1' then
			S_mo <= S1_mo;
		elsif Q_int = '1' and Q_int'event then
			S_mo <= S_folge_mo;
		end if;
	end process RK_mo;
	
	My_mo: process (S_mo)
	begin
		case S_mo is
			when S2_mo => Y_mo <= "001";
			when S4_mo => Y_mo <= "011";
			when S6_mo => Y_mo <= "101";
			when S7_mo => Y_mo <= "111";
			when others => Y_mo <= "--0";
		end case;
	end process My_mo;
	
	y2_mo <= Y_mo(2);
	y1_mo <= Y_mo(1);
	g_mo <= Y_mo(0);
	
end Behavioral;

