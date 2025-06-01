defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.

  """

  def tick(world) do
    survived_cells =
      Enum.reduce(world, [], &update_world(world, &1, :live, &2))

    reproduced_cells =
      Enum.reduce(world, [], fn cell, next_world ->
        get_dead_neighbours(world, cell)
        |> Enum.reduce([], &update_world(world, &1, :dead, &2))
        |> Enum.concat(next_world)
      end)

    MapSet.union(MapSet.new(survived_cells), MapSet.new(reproduced_cells)) |> MapSet.to_list()
  end

  def update_world(world, cell, current_state, next_world) do
    live_neighbours = Enum.count(get_live_neighbours(world, cell))
    next_state = evaluate_next_state(current_state, live_neighbours)

    case next_state do
      :live -> [cell | next_world]
      _ -> next_world
    end
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
