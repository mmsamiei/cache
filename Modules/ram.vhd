LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(clk, rw:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(9 downto 0);
         Data_in:in STD_LOGIC_VECTOR(31 downto 0);
         Data_out:out STD_LOGIC_VECTOR(31 downto 0);
		 Data_ready:out STD_LOGIC);
end ram;

architecture dataflow of ram is
    type ram_array is array (1023 downto 0) of std_logic_vector (31 downto 0);
    signal data_array : ram_array;
begin
    process(clk,rw,Data_in)
    begin
		Data_ready<='0';
        if(rw = '1' and  clk='1') then
            data_array(to_integer(unsigned(address))) <= Data_in;
			Data_ready<='0';
		end if;
		if(rw = '0' and  clk='1') then
			Data_out<=data_array(to_integer(unsigned(address)));
			Data_ready<='1';
			Data_ready<=transport '0' after 10ns;
		end if;
    end process;

end dataflow;
