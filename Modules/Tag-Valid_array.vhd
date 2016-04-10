LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Tag_Valid_array is
    port(clk, wren,invalidate:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(3 downto 0);
		 reset_n:in STD_LOGIC;
         output:out STD_LOGIC_VECTOR(4 downto 0));
end Tag_Valid_array;

architecture dataflow of Tag_Valid_array is
    
	type tag_array is array (63 downto 0) of std_logic_vector (3 downto 0);
	type valid_array is array (63 downto 0) of std_logic ;
	
	signal tag_array_instance : tag_array ;
	signal valid_array_instance : valid_array := (others=>'1');
	
begin
    process(clk,wren,invalidate,tag_array_instance,valid_array_instance)
    begin
		if(reset_n='1')then
			valid_array_instance <= (others=> '0');
		end if;
	
        if(wren = '1' and  clk='1') then
            tag_array_instance(to_integer(unsigned(address))) <= wrdata;
			valid_array_instance(to_integer(unsigned(address)))<='1';
			output <= valid_array_instance(to_integer(unsigned(address)))&tag_array_instance(to_integer(unsigned(address)));
		end if;

		if(invalidate = '1' and  clk='1') then
            valid_array_instance(to_integer(unsigned(address))) <= '0';
			output <= valid_array_instance(to_integer(unsigned(address)))&tag_array_instance(to_integer(unsigned(address)));
        end if;
		
        output <= valid_array_instance(to_integer(unsigned(address)))&tag_array_instance(to_integer(unsigned(address)));
    end process;
--output <= valid_array_instance(to_integer(unsigned(address)))&tag_array_instance(to_integer(unsigned(address)));
end dataflow;