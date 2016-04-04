-- Incorporates Errata 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is port (
  clk: in std_logic;
  reset: in std_logic;
  count: out std_logic);
end counter;

architecture simple of counter is

signal countL: std_logic :='0';

begin

  increment: process (clk, reset) begin
    if reset = '1' then
      countL <= '0';
    elsif(clk'event and clk = '1') then
      countL <= countL xor '1';
    end if;
  end process;
  
  count <= countL;

end simple;
