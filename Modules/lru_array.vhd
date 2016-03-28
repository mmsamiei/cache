LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(clk,k,inform:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         output:out STD_LOGIC);
end lru_array;

architecture dataflow of lru_array is
    type lru_array is array (63 downto 0) of std_logic;

    signal lru_array_instance : lru_array := (others=>'0');
begin
    process(clk,k,inform,lru_array_instance)
    begin
        if(inform = '1' and  clk='1') then
            lru_array_instance(to_integer(unsigned(address))) <= not k;
			output<=lru_array_instance(to_integer(unsigned(address)));
		end if;
		
		--if(lru_array_instance(to_integer(unsigned(address)))/='0' and lru_array_instance(to_integer(unsigned(address)))/='1') then
		--	output<='0';
		--	lru_array_instance(to_integer(unsigned(address))) <= '0';
		--	end if;
			
		output<=lru_array_instance(to_integer(unsigned(address)));	
		
    end process;
	--output<=lru_array_instance(to_integer(unsigned(address)));
	
end dataflow;
