defmodule RustnifTest do
  use ExUnit.Case
  doctest Rustnif

  test "greets the world" do
    assert Rustnif.hello() == :world
  end
end
