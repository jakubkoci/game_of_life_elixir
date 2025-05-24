defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "Greets" do
    assert GameOfLife.hello("Joe") == "Hello, Joe!"
  end

  test "Any live cell with fewer than two live neighbours dies, as if by underpopulation." do
    assert GameOfLife.next_cell_state(:live, 0) == :dead
    assert GameOfLife.next_cell_state(:live, 1) == :dead
  end

  test "Any live cell with two or three live neighbours lives on to the next generation." do
    assert GameOfLife.next_cell_state(:live, 2) == :live
    assert GameOfLife.next_cell_state(:live, 3) == :live
  end

  test "Any live cell with more than three live neighbours dies, as if by overpopulation." do
    assert GameOfLife.next_cell_state(:live, 4) == :dead
    assert GameOfLife.next_cell_state(:live, 5) == :dead
  end

  test "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
    assert GameOfLife.next_cell_state(:dead, 2) == :dead
    assert GameOfLife.next_cell_state(:dead, 3) == :live
    assert GameOfLife.next_cell_state(:dead, 4) == :dead
  end

  test "Return list of neighbours coordinates" do
    assert GameOfLife.get_neighbours({10, 10}) == [
             {9, 9},
             {10, 9},
             {11, 9},
             {9, 10},
             {10, 10},
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
             {20, 25},
             {21, 25},
             {19, 26},
             {20, 26},
             {21, 26}
           ]
  end
end
