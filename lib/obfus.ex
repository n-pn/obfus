defmodule Obfus do
  @moduledoc """
  Id obfuscation based on Knuth's multiplicative hashing method.
  """

  import Bitwise

  @default {2_147_483_647, 1_844_430_803, 627_648_603, 1_130_094_992}

  @doc """
  Encrypt id

  ## Examples

      iex> Obfus.encrypt(123)
      "4u4v01"

  """

  def encrypt(num, config \\ :default) do
    {max_id, prime, _, random} = Application.get_env(:obfus, config, @default)
    val = (num * prime &&& max_id) ^^^ random
    Integer.to_string(val, 36) |> String.downcase()
  end

  @doc """
  Decrypt id

  ## Examples

      iex> Obfus.decrypt("4u4v01")
      123

  """

  def decrypt(str, config \\ :default) do
    {max_id, _, inverse, random} = Application.get_env(:obfus, config, @default)
    val = String.to_integer(str, 36)
    (val ^^^ random) * inverse &&& max_id
  end
end
