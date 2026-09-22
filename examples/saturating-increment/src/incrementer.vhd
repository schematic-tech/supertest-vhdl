library ieee;
use ieee.numeric_std.all;

package incrementer is
  subtype byte_value is unsigned(7 downto 0);
  function saturating_increment(value : byte_value) return byte_value;
end package;

package body incrementer is
  function saturating_increment(value : byte_value) return byte_value is
  begin
    return value + 1;
  end function;
end package body;
