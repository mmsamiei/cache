LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_cache is
    port(clk, reset,read,write:buffer STD_LOGIC;
         addr:in STD_LOGIC_VECTOR(9 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         rddata:out STD_LOGIC_VECTOR(31 downto 0));
end ram_cache;

architecture dataflow of ram_cache is
    
	type state_type is (s0, s1, s2, s3,s4,s5,s6,s7);
	signal state   : state_type;
	
	component ram is
    port(clk, rw:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(9 downto 0);
         Data_in:in STD_LOGIC_VECTOR(31 downto 0);
         Data_out:out STD_LOGIC_VECTOR(31 downto 0);
		 Data_ready:out STD_LOGIC);
	end component;
	
	component cache is
    port(clk,write_to_cache,write:in STD_LOGIC;
		full_address:in STD_LOGIC_VECTOR(9 downto 0);
        wrdata:in STD_LOGIC_VECTOR(31 downto 0);
		hit:out std_logic;
		data:out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	signal ram_rw:std_logic:='0';
	signal ram_Data_in,ram_Data_out:std_logic_vector(31 downto 0);
	signal ram_Data_ready:std_logic;
	
	signal cache_write_to_cache:std_logic:='0';
	signal cache_wrdata:std_logic_vector(31 downto 0);
	signal cache_hit:std_logic;
	signal cache_data:std_logic_vector(31 downto 0);
	signal cache_write:std_logic:='0';
	
begin
	myRam : ram port map(clk=>clk,rw=>ram_rw,address=>addr,Data_in=>ram_Data_in,Data_out=>ram_Data_out,Data_ready=>ram_Data_ready);
	myCache : cache port map(clk=>clk,write_to_cache=>cache_write_to_cache,write=>cache_write,full_address=>addr,wrdata=>cache_wrdata,hit=>cache_hit,data=>cache_data);
	
	process(clk)
	begin
	if(reset='1')then
		state<=s0;
		read<='0';
		write<='0';
		ram_rw<='0';
		cache_write<='0';
	elsif (rising_edge(clk)) then
		case state is
			when s0=>
				if(write<='1')then
					state<=s1;
				elsif(read<='1')then
					state<=s2;
				end if;
			when s1=>
				cache_write<='1';
				ram_Data_in<=wrdata;
				ram_rw<='1';
				reset<='1';
			when s2=>
			
			when s3=>
			
			when s4=>
			
			when s5=>
			
			when s6=>
			
			when s7=>
		end case;
	end if;
	end process;
end dataflow;
