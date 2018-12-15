defmodule Day3 do
  @moduledoc """
  Documentation for Day3.
  """

  @doc """
  Parses a claim input line

  ## Examples

      iex> Day3.parse_claim("#1 @ 393,863: 11x29")
      [1, 393, 863, 11, 29]

  """
  def parse_claim(claim) when is_binary(claim) do
    claim
    |> String.split(["#", " @ ", ",", ": ", "x" ], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Builds claim map

  ## Examples

      iex> claims = Day3.build_claims_map([
      ...>  "#1 @ 1,3: 4x4",
      ...>  "#2 @ 3,1: 4x4",
      ...>  "#3 @ 5,5: 2x2"
      ...> ])
      iex> claims[{4, 3}]
      [2]
      iex> claims[{7, 7}]
      [3]
  """
  def build_claims_map(claims) when is_list(claims) do
    claims
    |> Enum.reduce(%{}, fn(claim, acc) ->
      [id, left, top, width, height] = parse_claim(claim)
      Enum.reduce(left+1..left+width, acc, fn(x, acc) ->
        Enum.reduce(top+1..top+height, acc, fn(y, acc) ->
          Map.update(acc, {x,y}, [id], &[id|&1])
        end)
      end)
    end)
  end

  @doc """
  Select overlapping points with more than two ids

  ## Examples

      iex> Day3.overlapping_points([
      ...>  "#1 @ 1,3: 4x4",
      ...>  "#2 @ 3,1: 4x4",
      ...>  "#3 @ 5,5: 2x2"
      ...> ])
      [{4, 4}, {4, 5}, {5, 4}, {5, 5}]
  """
  def overlapping_points(claims) when is_list(claims) do
    for {coordinate, [_,_ | _]} <- build_claims_map(claims), do: coordinate
  end

  @doc """
  Find number of overlapping points counts

  ## Examples

      iex> Day3.overlapping_points_count("input.txt")
      98005
  """
  def overlapping_points_count(filename) when is_binary(filename) do
    filename
    |> File.read!
    |> String.split("\n", trim: true)
    |> overlapping_points
    |> length
  end
end


