
--necessary libraries----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
entity my_mux is
port ( a,b : in  std_logic_vector(31 downto 0);
       s : in  std_logic;
       o : out std_logic_vector(31 downto 0));
end my_mux;
architecture mux of my_mux is
signal o1,o2: std_logic_vector(31 downto 0);

begin

process(s,a,b)
begin
	case s is
	when '0'=>o<=a;
	when '1'=>o<=b;
	when others=> o<=a;
	end case ;
end process;



end mux;