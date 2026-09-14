# Supertest for VHDL

Compile [schematic.vhd](https://raw.githubusercontent.com/schematic-tech/supertest-vhdl/v0.1.1/src/schematic.vhd) into your work library using VHDL-2008.

```vhdl
entity arithmetic is
  port (value, divisor : in integer);
end entity;

use work.schematic.all;

architecture supertests of arithmetic is
begin
  --% supertest
  integer_division_is_bounded : process
  begin
    supertest_assume(value >= 0 and divisor > 0);
    assert value / divisor <= value severity failure;
    wait;
  end process;
end architecture;
```

See the [Getting Started Documentation](https://docs.schematic.tech/pup).

## License

This library is available under either MIT or Apache-2.0, at your option.
