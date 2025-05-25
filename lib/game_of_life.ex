defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GameOfLife.hello("Joe")
      "Hello, Joe!"

  """
  def hello(name) do
    "Hello, #{name}!"
  end

  def get_neighbours(cell) do
    {x, y} = cell

    grid =
      List.flatten([
        Enum.map(-1..1, fn i -> {x + i, y - 1} end),
        Enum.map(-1..1, fn i -> {x + i, y} end),
        Enum.map(-1..1, fn i -> {x + i, y + 1} end)
      ])

    neighbours = Enum.filter(grid, fn c -> c != cell end)
    neighbours
  end

  def get_live_neighbours(world, cell) do
    neighbours = get_neighbours(cell)

    is_alive = fn cell -> Enum.find(world, fn c -> c == cell end) end
    live_neighbours = Enum.filter(neighbours, is_alive)

    live_neighbours
  end

  def next_cell_state(current_state, count_of_living_neighbours) do
    next_state =
      case {current_state, count_of_living_neighbours} do
        {:live, 2} -> :live
        {:live, 3} -> :live
        {:dead, 3} -> :live
        _ -> :dead
      end

    next_state
  end
end
