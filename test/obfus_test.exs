defmodule ObfusTest do
  use ExUnit.Case
  doctest Obfus

  test "greets the world" do
    assert Obfus.hello() == :world
  end
end
