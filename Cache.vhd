LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk,write:in STD_LOGIC;
		full_address:in STD_LOGIC_VECTOR(9 downto 0);
        wrdata:in STD_LOGIC_VECTOR(31 downto 0);
		hit:out std_logic;
		data:out STD_LOGIC_VECTOR(31 downto 0));
end cache;

architecture dataflow of cache is
	component data_array port(clk, wren:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         data:out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	component lru_array port(clk,k,inform:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         output:out STD_LOGIC);
	end component;
	
	component miss_hit_logic port(hit,w0_valid,w1_valid:buffer STD_LOGIC;
         tag:in STD_LOGIC_VECTOR(3 downto 0);
         w0,w1:in STD_LOGIC_VECTOR(4 downto 0));
	end component;
	
	component Tag_Valid_array port(clk, wren,reset_n,invalidate:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(3 downto 0);
         output:out STD_LOGIC_VECTOR(4 downto 0));
	end component;
	
	
	type state_type is (s0, s1, s2, s3);
	signal state   : state_type;
	
	
	signal k0_wren:std_logic;
	signal k1_wren:std_logic;
	signal k0_data : STD_LOGIC_VECTOR(31 downto 0);
	signal k1_data : STD_LOGIC_VECTOR(31 downto 0);
	signal k0_tag_wren:std_logic;
	signal k0_tag_invalidate:std_logic;
	signal k0_tag_wrdata:std_logic_vector(3 downto 0);
	signal k0_tag_output:std_logic_vector(4 downto 0);
	signal k1_tag_wren:std_logic;
	signal k1_tag_invalidate:std_logic;
	signal k1_tag_wrdata:std_logic_vector(3 downto 0);
	signal k1_tag_output:std_logic_vector(4 downto 0);
	signal k_lru_array,inform_lru_array,output_lru_array:std_logic;
	signal hit_logic_hit,hit_logic_w0_valid,hit_logic_w1_valid:std_logic;
	signal hit_logic_tag  : std_logic_vector(3 downto 0);
	signal hit_logic_w0,hit_logic_w1: std_logic_vector(4 downto 0);

	
	
	
begin

	k0_tag_invalidate<=hit_logic_hit and write;
	k1_tag_invalidate<=hit_logic_hit and write;
 	
	
	
	k0_tag_wren<= k0_wren;
	k1_tag_wren<= k1_wren;
	
	--k0_wren<= (not (hit_logic_hit) and not (output_lru_array)) ;
	--k1_wren<= (not (hit_logic_hit) and  (output_lru_array)) ;
	 
	k0_wren<= not output_lru_array and write;
	k1_wren<= output_lru_array and write;
	 
	--inform_lru_array<=(hit_logic_hit) and write;
	k_lru_array<=k1_wren;
	
	inform_lru_array<=write;
	
	
	

	k0_data_array: data_array port map(clk=>clk,wren=>k0_wren,address=>full_address(5 downto 0),wrdata=>wrdata,data=>k0_data);
	
	k1_data_array: data_array port map(clk=>clk,wren=>k1_wren,address=>full_address(5 downto 0),wrdata=>wrdata,data=>k1_data);
	
	k0_Tag_Valid_array: Tag_Valid_array port map(clk=>clk,wren=>k0_tag_wren,invalidate=>k0_tag_invalidate,address=>full_address(5 downto 0),wrdata=>full_address(9 downto 6),output=>k0_tag_output,reset_n=>'0');
	
	k1_Tag_Valid_array: Tag_Valid_array port map(clk=>clk,wren=>k1_tag_wren,invalidate=>k1_tag_invalidate,address=>full_address(5 downto 0),wrdata=>full_address(9 downto 6),output=>k1_tag_output,reset_n=>'0');
	
	lru_circuite : lru_array port map(clk=>clk,k=>k_lru_array,inform=>inform_lru_array,address=>full_address(5 downto 0),output=>output_lru_array);
	
	miss_hit_circuite : miss_hit_logic port map (hit=>hit_logic_hit,w0_valid=>hit_logic_w0_valid,w1_valid=>hit_logic_w1_valid,tag=>full_address(9 downto 6),w0=>k0_tag_output,w1=>k1_tag_output);
	
	
	
	
	
end dataflow;
