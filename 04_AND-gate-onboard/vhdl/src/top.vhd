library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    i_sw_s1 : in std_logic;
    i_sw_s2 : in std_logic;
    o_led_done : out std_logic;
    o_led_ready : out std_logic);
end entity top;

architecture RTL of top is

begin

  o_led_ready <= '0';  -- Switch off LED READY
  o_led_done <= i_sw_s1 and i_sw_s2;

end RTL;
