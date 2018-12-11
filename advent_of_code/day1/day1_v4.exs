defmodule Day1 do
  def final_frequency(file_stream) do
    file_stream
    # Here we need to remove the \n from the input line either by
    # |> Stream.map(fn(line) -> line |> String.trim |> String.to_integer end)
    # or a better way would be to use Integer.parse
    |> Stream.map(fn(line) ->
      { integer, _leftover } = Integer.parse(line)
      integer
    end)
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
        {:ok, io} = StringIO.open("""
        +1
        +1
        -2
        """)
        assert final_frequency(io |> IO.stream(:line)) == 0
      end
    end

  [inputfilename] ->
    inputfilename
    |> File.stream!([], :line)
    |> Day1.final_frequency()
    |> IO.puts

  _ ->
    IO.puts :stderr, "We expect --test or inputfile"
    System.halt(1)
end