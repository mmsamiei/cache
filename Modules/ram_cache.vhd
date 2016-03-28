LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_cache is
    port(clk, reset,read,write:in STD_LOGIC;
         addr:in STD_LOGIC_VECTOR(9 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         rddata:out STD_LOGIC_VECTOR(31 downto 0));
end ram_cache;

architecture dataflow of ram_cache is
    
	type state_type is (s0, s1, s2, s3);
	signal state   : state_type;
	
	component ram is
    port(clk, rw:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(9 downto 0);
         Data_in:in STD_LOGIC_VECTOR(31 downto 0);
         Data_out:out STD_LOGIC_VECTOR(31 downto 0);
		 Data_ready:out STD_LOGIC);
	end component;
	
	component cache is
    port(clk:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         data:out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	
begin
    if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if read = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					
					if data_in = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
				when s2=>
					if data_in = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3 =>
					if data_in = '1' then
						state <= s0;
					else
						state <= s3;
					end if;
			end case;
		end if;
	end process;

end dataflow;
