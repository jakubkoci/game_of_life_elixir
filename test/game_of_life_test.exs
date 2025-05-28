defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  describe "tick" do
    test "on empty world returns empty world" do
      assert GameOfLife.tick([]) == []
    end

    test "transforms three horizontal neighbours to vertical ones" do
      assert GameOfLife.tick([{9, 10}, {10, 10}, {11, 10}]) == [
               {10, 9},
               {10, 10},
               {10, 11}
             ]
    end
  end

  test "returns live neighbour of a dead cell" do
    # empty world
    assert GameOfLife.get_live_neighbours([], {10, 10}) == []

    # world with one live cell next to a dead cell
    assert GameOfLife.get_live_neighbours([{9, 9}], {10, 10}) == [{9, 9}]
  end

  test "returns live neighbours of a live cell" do
    # world with three live cells, but only one is next to a live cell
    assert GameOfLife.get_live_neighbours([{8, 8}, {9, 9}, {10, 10}], {10, 10}) == [{9, 9}]

    # world with four live cells, but only two are next to a live cell
    assert GameOfLife.get_live_neighbours([{8, 8}, {9, 9}, {10, 10}, {11, 11}], {10, 10}) == [
             {9, 9},
             {11, 11}
           ]
  end

  test "returns dead neighbours of a cell" do
    assert GameOfLife.get_dead_neighbours([{9, 9}], {10, 10}) == [
             {10, 9},
             {11, 9},
             {9, 10},
             {11, 10},
             {9, 11},
             {10, 11},
             {11, 11}
           ]
  end

  test "return list of neighbours" do
    assert GameOfLife.get_neighbours({10, 10}) == [
             {9, 9},
             {10, 9},
             {11, 9},
             {9, 10},
             {11, 10},
             {9, 11},
             {10, 11},
             {11, 11}
           ]

    assert GameOfLife.get_neighbours({20, 25}) == [
             {19, 24},
             {20, 24},
             {21, 24},
             {19, 25},
             {21, 25},
             {19, 26},
             {20, 26},
             {21, 26}
           ]
  end

  test "live cell with fewer than two live neighbours dies" do
    assert GameOfLife.evaluate_next_state(:live, 0) == :dead
    assert GameOfLife.evaluate_next_state(:live, 1) == :dead
  end

  test "live cell with two or three live neighbours survives" do
    assert GameOfLife.evaluate_next_state(:live, 2) == :live
    assert GameOfLife.evaluate_next_state(:live, 3) == :live
  end

  test "live cell with more than three live neighbours dies" do
    assert GameOfLife.evaluate_next_state(:live, 4) == :dead
    assert GameOfLife.evaluate_next_state(:live, 5) == :dead
  end

  test "dead cell with exactly three live neighbours becomes alive" do
    assert GameOfLife.evaluate_next_state(:dead, 2) == :dead
    assert GameOfLife.evaluate_next_state(:dead, 3) == :live
    assert GameOfLife.evaluate_next_state(:dead, 4) == :dead
  end
end
