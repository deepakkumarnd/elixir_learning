defmodule Day2Part2 do
  def common_box_id_letters(input) do
    input
    |> String.split("\n", trim: true)
    |> find_string_diff()
  end

  def find_string_diff(list) when is_list(list) do
    list
    |> Enum.map(&String.codepoints(&1))
    |> match_code_points([])
    |> common_letters()
  end

  def common_letters([a|b]) do
    Enum.zip(a,b)
    |> Enum.map(fn({a,b}) ->
      if a == b, do: a, else: ''
    end)
    |> List.to_string()
  end

  def match_code_points([head|tail], acc) do
    items = Enum.filter(tail, &find_single_match(head, &1))

    acc = acc ++ if length(items) > 0 do
      items ++ head
    else
      []
    end

    match_code_points(tail, acc)
  end

  def match_code_points([], acc) do
    acc
  end

  def find_single_match(arr1, arr2) do
    Enum.zip(arr1, arr2)
    |> Enum.count(fn({a,b}) -> a != b end) == 1
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day2Test do
      use ExUnit.Case

      test "find the checksum for the list of strings" do
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
    |> IO.inspect(label: "Checksum")

  _ ->
    IO.puts(:stderr, "We expect a filename or --test as the parameter")
    System.halt(1)
end