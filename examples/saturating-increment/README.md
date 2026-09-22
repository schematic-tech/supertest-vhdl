# Saturating increment

An 8-bit saturating incrementer adds one to its input, stopping at 255. The supertest
requires that incrementing a value never makes it smaller.

This example deliberately contains a bug: ordinary 8-bit addition wraps 255 to zero.

## Set up

With GHDL and Make installed, run from the repository root:

```sh
cd examples/saturating-increment
make
```

The example uses VHDL-2008. Its supertest is the labeled process immediately after
`--% supertest` in `supertests/increment.vhd`. The input port covers the integers
from 0 through 255.

## Check and fix

[Install the Schematic CLI and log in](https://docs.schematic.tech/pup/get-started/), then run
from this example directory:

```sh
sch link .
sch check .
```

The CLI links the containing `supertest-vhdl` repository. The `.` in `sch check .`
selects only this example.

The check should fail at 255: the function returns zero, violating the
requirement that incrementing a value never makes it smaller.

Review and apply the proposed fix, then check again:

```sh
sch fix
sch check .
```

The CLI asks before applying the fix and whether to include uncommitted changes.
