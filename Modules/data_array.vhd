LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_array is
    port(clk, wren:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         data:out STD_LOGIC_VECTOR(31 downto 0));
end data_array;

architecture dataflow of data_array is
    type cache_array is array (63 downto 0) of std_logic_vector (31 downto 0);
    signal data_array : cache_array;
begin
    process(clk,wren,data_array)
    begin
        if(wren = '1' and  clk='1') then
            data_array(to_integer(unsigned(address))) <= wrdata;
        end if;

        data <= data_array(to_integer(unsigned(address)));
    end process;

end dataflow;
