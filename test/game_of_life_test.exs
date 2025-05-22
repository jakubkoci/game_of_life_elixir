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
end
