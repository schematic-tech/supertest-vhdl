use work.schematic.all;

entity authoring is
  generic (test_mode : natural := 0);
end entity;

architecture simulation of authoring is
begin
  --% supertest
  assumption_behavior : process
    variable calls : natural := 0;
    impure function condition return boolean is
    begin
      calls := calls + 1;
      return test_mode /= 1;
    end function;
  begin
    report "entered" severity note;
    supertest_assume(condition);
    assert calls = 1 report "condition evaluated more than once" severity failure;
    if test_mode = 1 then
      report "continued after rejected input" severity failure;
      std.env.finish(91);
    elsif test_mode = 2 then
      assert false report "ordinary assertion failure" severity failure;
      std.env.finish(92);
    else
      report "continued" severity note;
      std.env.finish(0);
    end if;
    wait;
  end process;

  -- Rejecting an input must finish even when another process keeps time moving.
  watchdog : process
  begin
    wait for 1 ns;
    assert false report "simulation did not finish" severity failure;
    std.env.finish(93);
    wait;
  end process;
end architecture;
