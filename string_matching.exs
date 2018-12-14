# Given two patters of same length, find the percentage of match between those pattern

# eg: 'abcd', 'abcd' => 100% match
# eg2: 'abcd', 'aefg' => 25% match

defmodule StringMatching do
  def match(pattern1, pattern2) do
    if String.length(pattern1) == String.length(pattern2), do: match(String.to_charlist(pattern1), String.to_charlist(pattern2), 0), else: 0
  end

  defp match([head|tail1], [head|tail2], match_count) do
    match(tail1, tail2, match_count + 1)
  end

  defp match([_|tail1], [_|tail2], match_count) do
    match(tail1, tail2, match_count)
  end

  defp match([], [], match_count) do
    (match_count/6)
    |> Kernel.*(100)
    |> :erlang.float_to_binary([decimals: 2])
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()
    defmodule StringMatchingTest do
      use ExUnit.Case

      test "prints the match percentage between two patters" do
        assert StringMatching.match("abcdef", "abcdeg") == "83.33"
      end
    end
end