defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.

  Todo
  - [x] Step-down rule
  - [ ] Extract into modules to be able to test without run/render
  - [ ] Refactor next state to use one function

  """

  def render(world) do
    for y <- 0..9 do
      line =
        Enum.to_list(0..9)
        |> Enum.map(fn x ->
          case is_alive(world, {x, y}) do
            true -> "x "
            _ -> "o "
          end
        end)

      IO.puts(line)
    end

    IO.puts("\n")
  end

  def tick(world) do
    survived_cells =
      Enum.reduce(world, [], fn cell, acc ->
        live_neighbours = Enum.count(get_live_neighbours(world, cell))
        next_state = evaluate_next_state(:live, live_neighbours)

        case next_state do
          :live -> [cell | acc]
          _ -> acc
        end
      end)

    reproduced_cells =
      Enum.reduce(world, [], fn cell, acc ->
        get_dead_neighbours(world, cell)
        |> Enum.reduce([], fn cell, acc ->
          live_neighbours = Enum.count(get_live_neighbours(world, cell))
          next_state = evaluate_next_state(:dead, live_neighbours)

          case next_state do
            :live -> [cell | acc]
            _ -> acc
          end
        end)
        |> Enum.concat(acc)
      end)

    MapSet.union(MapSet.new(survived_cells), MapSet.new(reproduced_cells)) |> MapSet.to_list()
  end

  def get_live_neighbours(world, cell) do
    neighbours = get_neighbours(cell)
    Enum.filter(neighbours, &is_alive(world, &1))
  end

  def get_dead_neighbours(world, cell) do
    neighbours = get_neighbours(cell)
    Enum.filter(neighbours, &is_dead(world, &1))
  end

  def is_alive(world, cell) do
    Enum.any?(world, fn c -> c == cell end)
  end

  def is_dead(world, cell) do
    not is_alive(world, cell)
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

  def evaluate_next_state(current_state, count_of_living_neighbours) do
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
