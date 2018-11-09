# Obfus

Id obfuscation based on Knuth's multiplicative hashing method.

## Install

In `mix.exs`:

```elixir
{:obfus, git: "https://github.com/nipinium/obfus.git", tag: "v0.1.0"}
```

## Usage

Encrypting id:

```elixir
# using default schema
Obfus.encrypt(123) # => "4u4v01"

# using other schema (must be set in config.exs)
Obfus.encrypt(123, :article) => "1jyf83i"
```

Decrypting id:

```elixir
# using default schema
Obfus.decrypt("4u4v01") # => 123

# using other schema (must be set in config.exs)
Obfus.decrypt("1jyf83i", :article) # => 123
```

### Configure

In `config.exs`:

```elixir
# override default schema {max_id, prime, inverse, random}
config :obfus, default: {2_147_483_647, 1_844_430_803, 627_648_603, 1_130_094_992}

# add another schema
config :obfus, article: {2_147_483_647, 1_776_270_863, 1_922_658_543, 1_640_987_636}
```

Generate `{max_id, prime, inverse, random}` tuple for schemas:

```sh
# random prime number
$ mix obfus
{2147483647, 1776270863, 1922658543, 1640987636}

# custom prime number
$ mix obfus 1798850507
{2147483647, 1798850507, 1495803363, 1556056063}

# custom prime number and max_id
$ mix obfus 1798850507 4294967295
{4294967295, 1798850507, 1495803363, 1302399543}
```

## License

The Unlicense
