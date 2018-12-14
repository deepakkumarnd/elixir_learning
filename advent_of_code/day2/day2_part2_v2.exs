defmodule Day2Part2 do
  def common_box_id_letters(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> closest()
  end

  def closest([head|tail]) do
    Enum.find_value(tail, &one_char_difference(&1, head)) || closest(tail)
  end

  def one_char_difference(charlist1, charlist2) do
    one_char_difference(charlist1, charlist2, [], 0)
  end

  def one_char_difference([head|tail1], [head|tail2], same, difference_count) do
    one_char_difference(tail1, tail2, [head|same], difference_count)
  end

  def one_char_difference([_|tail1], [_|tail2], same, difference_count) do
    one_char_difference(tail1, tail2, same, difference_count + 1)
  end

  # since the length of each string is same they will become empty at the same time
  def one_char_difference([], [], same, 1) do
    same
    |> Enum.reverse()
    |> List.to_string()
  end

  def one_char_difference([], [], _same, _) do
    nil
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day2Test do
      use ExUnit.Case

      test "find the matching letters in the list of box ids" do
        input = """
          abcde
          fghij
          klmno
          pqrst
          fguij
          axcye
          wvxyz
          """
        assert Day2Part2.common_box_id_letters(input) == "fgij"
      end
    end

  [inputfilename] ->
    inputfilename
    |> File.read!()
    |> Day2Part2.common_box_id_letters()
    |> IO.inspect(label: "Common letters:")

  _ ->
    IO.puts(:stderr, "We expect a filename or --test as the parameter")
    System.halt(1)
end