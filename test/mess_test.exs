defmodule MessTest do
  use ExUnit.Case
  doctest Mess

  test "greets the world" do
    assert Mess.hello() == :world
  end
end
