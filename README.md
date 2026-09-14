# Supertest for VHDL

Analyze `src/schematic.vhd` into your work library before the supertest source,
using VHDL-2008. Use the package namespace for short names:

```vhdl
use work.schematic.all;

-- Inside an architecture, with entity inputs value and divisor:
--% supertest
integer_division_is_bounded : process
begin
  supertest_assume(value >= 0 and divisor > 0);
  assert value / divisor <= value severity failure;
  wait;
end process integer_division_is_bounded;
```

The exact `--% supertest` comment marks the next non-comment construct, a labeled
process. Its label is the supertest name, and enclosing entity input ports supply
property inputs. The marker has no ordinary simulation effect.

`supertest_assume` belongs to package `schematic`; `work.schematic.supertest_assume(condition)` also
works without an import. VHDL-2008 reserves `assume`, so the procedure uses the
`supertest_` prefix. The old `schematic_assume` name is removed.

A true assumption continues. A false assumption calls `std.env.finish(0)`, ending
the entire simulation successfully. Run one input per simulation. This replaces
the old permanent `wait`, which could leave other processes running indefinitely.
The procedure no longer waits, so it imposes no sensitivity-list restriction.
It is for simulation and source-level verification, not synthesis.

```sh
make test
```

Requires GHDL with VHDL-2008 support, Make, and Python 3 for subprocess checks.
Simulator behavior has been validated with GHDL; other simulators may have their
own host exit-status conventions. These authoring
primitives do not imply that the current Pup checker discovers VHDL.

Adapted from `schematic-tech/schematic-supertests` at
`b6ccba3b5e0d42ea2846d0476eeb9496afb4a7f4`.

## Distribution

Download `schematic.vhd` from a tagged source tree or GitHub Release, or add this
checkout to FuseSoC:

```sh
fusesoc library add schematic-supertest /path/to/supertest-vhdl
fusesoc run --target=sim schematic:verification:supertest
```

The core manifest declares VHDL-2008 source. Consumers may depend on
`schematic:verification:supertest:0.1.0`. See [release assets and download URLs](RELEASING.md).

## License

This interoperability library is available under either [MIT](LICENSE-MIT) or
[Apache-2.0](LICENSE-APACHE), at your option.
