defmodule FileSplitter do

  def usage do
    IO.puts "Usage: elixir #{Path.basename(__ENV__.file)} <file_to_split> <number_of_parts>"
  end

  def number_of_lines(filename) do
    filename
      |> File.stream!
      |> Enum.count
  end

  def save_part(lines, chunk_id) do
    case File.open("part_#{chunk_id}", [:write]) do
      {:ok, file} ->
        Enum.each(lines, &IO.puts(file, &1))
        File.close(file)
      _ ->
        IO.puts "Unable to open the fille for writing."
    end
  end

  def split(filename, parts) do
    lines_per_file = filename
      |> number_of_lines
      |> div(parts)

    if lines_per_file < 1 do
      IO.puts "Cannot split this file."
      System.halt()
    end

    filename
      |> File.stream!
      |> Stream.chunk_every(lines_per_file)
      |> Stream.with_index
      |> Stream.each(fn({lines, chunk_id}) -> save_part(lines, chunk_id) end)
      |> Stream.run
  end
end

case System.argv() do
  [filename, parts] ->
    IO.puts "#{filename} #{parts}"
    FileSplitter.split(filename, String.to_integer(parts))
  _ ->
    FileSplitter.usage
end