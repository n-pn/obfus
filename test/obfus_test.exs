defmodule ObfusTest do
  use ExUnit.Case
  doctest Obfus

  @max_id 2_147_483_647
  test "encypted integer should decrypted to that integer" do
    assert Obfus.encrypt(1) |> Obfus.decrypt() == 1
    assert Obfus.encrypt(10) |> Obfus.decrypt() == 10
    assert Obfus.encrypt(100) |> Obfus.decrypt() == 100
    assert Obfus.encrypt(1000) |> Obfus.decrypt() == 1000
    assert Obfus.encrypt(10000) |> Obfus.decrypt() == 10000
    assert Obfus.encrypt(100_000) |> Obfus.decrypt() == 100_000
    assert Obfus.encrypt(1_000_000) |> Obfus.decrypt() == 1_000_000
    assert Obfus.encrypt(10_000_000) |> Obfus.decrypt() == 10_000_000
    assert Obfus.encrypt(100_000_000) |> Obfus.decrypt() == 100_000_000
    assert Obfus.encrypt(1_000_000_000) |> Obfus.decrypt() == 1_000_000_000

    num = :random.uniform(@max_id)
    assert Obfus.encrypt(num) |> Obfus.decrypt() == num
  end
end
