LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(clk,inform:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         output:out STD_LOGIC;
		 ready:buffer STD_LOGIC);
end lru_array;

architecture dataflow of lru_array is
    type lru_array is array (63 downto 0) of std_logic;

    signal lru_array_instance : lru_array := (others=>'0');
	signal virtuall_clk:std_logic;
	signal reset:std_logic:='0';
begin
	
	virtuall_clk<= clk and inform;
	process (virtuall_clk, reset) begin
		ready<='0';
		if reset = '1' then
			lru_array_instance(to_integer(unsigned(address))) <= '0';
		elsif(virtuall_clk'event and virtuall_clk = '1') then
			lru_array_instance(to_integer(unsigned(address))) <= lru_array_instance(to_integer(unsigned(address))) xor '1';
			output<=lru_array_instance(to_integer(unsigned(address)));
			ready<='1';
			ready<=transport '0' after 10ns;
		end if;
		--ready<='1';
		ready<=transport '0' after 10ns;
	end process;
	
end dataflow;
