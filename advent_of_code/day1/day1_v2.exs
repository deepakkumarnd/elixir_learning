defmodule Day1 do
  def final_frequency(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn(line) -> String.to_integer(line) end)
    |> Enum.sum()
  end
end


case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day1Test do

      use ExUnit.Case
      import Day1

      test "final_frequency" do
        assert final_frequency("""
        +1
        +1
        -2
        """) == 0
      end
    end

  [inputfilename] ->
    inputfilename
    |> File.read!()
    |> Day1.final_frequency()
    |> IO.puts

  _ ->
    IO.puts :stderr, "We expect --test or inputfile"
    System.halt(1)
end