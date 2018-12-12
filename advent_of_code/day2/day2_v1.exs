defmodule Day2 do

  def input_checksum(input_string) do
    input_string
    |> String.split("\n", trim: true)
    |> Enum.map(&(checksum_block(&1)))
    |> final_checksum()
  end

  def final_checksum(list) do
    { twice, thrice } = Enum.reduce(list, {0,  0},
      fn({a,b}, acc) ->
        { a + elem(acc, 0), b + elem(acc, 1)}
      end)

    twice * thrice
  end

  def checksum_block(string) do
    string
    |> count_characters()
    |> count_twice_and_thrice()
  end

  def count_characters(string) when is_binary(string) do
    string
    |> String.to_charlist()
    |> count_characters(%{})
  end

  defp count_characters([head|tail], acc) do
    acc = Map.update(acc, head, 1, &(&1 + 1))
    count_characters(tail, acc)
  end

  defp count_characters([], acc) do
    acc
  end

  defp count_twice_and_thrice(char_count) when is_map(char_count) do
    twice = Enum.count(char_count, fn({_char, count}) -> count == 2 end)
    thrice = Enum.count(char_count, fn({_char, count}) -> count == 3 end)
    { min(1,twice), min(1,thrice) }
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day2Test do
      use ExUnit.Case

      test "counts the characters in a string" do
        assert Day2.count_characters("bababc") == %{
          ?a => 2,
          ?b => 3,
          ?c => 1
        }
      end

      test "counts even characters in a string are non ascii" do
        assert Day2.count_characters("déép") == %{
          ?d => 1,
          ?é => 2,
          ?p => 1
        }
      end

      test "finds the checksum" do
        assert Day2.checksum_block("bababc") == {1, 1}
      end

      test "find the checksum for the list of strings" do
        input = """
          abcdef
          bababc
          abbcde
          abcccd
          aabcdd
          abcdee
          ababab
          """
        assert Day2.input_checksum(input) == 12
      end
    end

  [inputfilename] ->
    inputfilename
    |> File.read!()
    |> Day2.input_checksum()
    |> IO.inspect(label: "Checksum")

  _ ->
    IO.puts :stderr, "We expect a filename or --test as the parameter"
    System.halt(1)
end