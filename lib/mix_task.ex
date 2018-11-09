defmodule Mix.Tasks.Obfus do
  @moduledoc """
  Generate a tuple of prime number, its inverse number and a random number.
  """

  use Mix.Task

  @max_id 2_147_483_647

  def run(args) do
    prime = parse_arg(args, 0) || gen_prime()
    max_id = parse_arg(args, 1) || @max_id
    random = gen_random()
    inverse = gen_inverse(prime, max_id)

    IO.inspect({max_id, prime, inverse, random})
  end

  defp parse_arg(args, idx) do
    case Enum.at(args, idx) do
      nil -> nil
      str -> String.to_integer(str)
    end
  end

  @primes [
    1_621_375_979,
    1_664_718_323,
    1_671_021_887,
    1_674_800_363,
    1_678_068_023,
    1_685_236_439,
    1_687_237_859,
    1_691_893_079,
    1_693_932_827,
    1_700_097_779,
    1_700_600_999,
    1_705_180_199,
    1_714_971_359,
    1_719_139_967,
    1_723_835_903,
    1_724_036_123,
    1_725_754_727,
    1_734_604_679,
    1_736_761_799,
    1_742_229_779,
    1_744_249_763,
    1_747_504_763,
    1_749_611_987,
    1_752_560_879,
    1_755_997_547,
    1_757_718_143,
    1_760_052_419,
    1_768_941_047,
    1_775_183_687,
    1_784_212_643,
    1_795_968_743,
    1_803_798_539,
    1_823_243_867,
    1_823_336_183,
    1_825_663_199,
    1_827_585_479,
    1_829_036_663,
    1_831_161_779,
    1_839_466_859,
    1_840_395_407,
    1_842_041_039,
    1_844_489_939,
    1_848_932_747,
    1_850_275_403,
    1_854_483_287,
    1_859_222_507,
    1_861_549_619,
    1_863_849_467,
    1_872_498_359,
    1_874_285_927,
    1_875_488_207,
    1_876_904_879,
    1_879_586_867,
    1_881_155_747,
    1_887_364_967,
    1_888_939_727,
    1_889_882_627,
    1_896_673_343,
    1_898_295_467,
    1_900_260_347,
    1_905_067_427,
    1_909_282_307,
    1_923_317_567,
    1_929_562_907,
    1_932_794_663,
    1_937_178_263,
    1_938_533_867,
    1_948_468_043,
    1_949_561_183,
    1_950_037_823,
    1_951_930_979,
    1_957_216_007,
    1_958_456_663,
    1_963_093_283,
    1_964_131_679,
    1_973_225_747,
    1_979_027_459,
    1_987_508_219,
    2_000_657_987,
    2_001_650_879,
    2_021_406_287,
    2_021_645_819,
    2_026_370_903,
    2_028_228_023,
    2_030_236_199,
    2_035_032_239,
    2_054_136_467,
    2_056_445_759,
    2_065_055_303,
    2_076_757_967,
    2_084_496_683,
    2_096_510_387,
    2_107_764_047,
    2_109_311_627,
    2_117_750_567,
    2_122_814_423,
    2_125_327_367,
    2_133_994_223,
    2_140_896_827,
    2_146_682_927
  ]

  defp gen_prime() do
    IO.puts("""
    No prime number entered, so we picked one from 100 pre-selected elements.
    You can choose another number from http://compoasso.free.fr/primelistweb/page/prime/liste_online_en.php
    """)

    Enum.random(@primes)
  end

  defp gen_random(min \\ 100_000_000, max \\ @max_id) do
    :rand.uniform(max - min) + min
  end

  defp gen_inverse(prime, max_id) do
    inverse(prime, max_id + 1)
  end

  defp inverse(e, et) do
    {g, x} = extended_gcd(e, et)
    if g != 1, do: raise("The maths are broken!")
    rem(x + et, et)
  end

  defp extended_gcd(a, b) do
    {last_remainder, last_x} = extended_gcd(abs(a), abs(b), 1, 0, 0, 1)
    {last_remainder, last_x * if(a < 0, do: -1, else: 1)}
  end

  defp extended_gcd(last_remainder, 0, last_x, _, _, _), do: {last_remainder, last_x}

  defp extended_gcd(last_remainder, remainder, last_x, x, last_y, y) do
    quotient = div(last_remainder, remainder)
    remainder2 = rem(last_remainder, remainder)
    extended_gcd(remainder, remainder2, x, last_x - quotient * x, y, last_y - quotient * y)
  end
end
