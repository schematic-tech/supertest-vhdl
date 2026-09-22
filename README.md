# Supertest for VHDL

Compile [schematic.vhd](https://raw.githubusercontent.com/schematic-tech/supertest-vhdl/v0.1.1/src/schematic.vhd) into your work library using VHDL-2008.

From the [saturating-increment example](examples/saturating-increment):

```vhdl
library ieee;
use ieee.numeric_std.all;
use work.incrementer.all;

entity increment_supertests is
  port (value : in natural range 0 to 255);
end entity;

architecture supertests of increment_supertests is
begin
  --% supertest
  increment_never_decreases : process
  begin
    assert to_integer(saturating_increment(to_unsigned(value, 8))) >= value
      report "Increment decreased the value" severity failure;
    wait;
  end process;
end architecture;
```

See the [Getting Started Documentation](https://docs.schematic.tech/pup).

## Example

Try [saturating-increment](https://github.com/schematic-tech/supertest-vhdl/tree/main/examples/saturating-increment), an 8-bit incrementer with a supertest that catches overflow.

## License

This library is available under either MIT or Apache-2.0, at your option.
