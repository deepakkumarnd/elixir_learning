defmodule BstreeTest do
  use ExUnit.Case
  doctest Bstree

  test "creates a new binary search tree" do
    assert Bstree.new(10) == %Bstree{left: :leaf, right: :leaf, data: 10}
  end

  test "inserts a new item to the tree" do
    tree = Bstree.new(10)
    tree = Bstree.insert(tree, 1)
    assert tree == %Bstree{
      left: %Bstree{
        left: :leaf,
        right: :leaf,
        data: 1
      },
      right: :leaf,
      data: 10
    }

    tree = Bstree.insert(tree, 11)

    assert tree == %Bstree{ tree | right: %Bstree{
        left: :leaf,
        right: :leaf,
        data: 11
      }
    }

    tree = Bstree.insert(tree, 5)

    assert tree == %Bstree{
      left: %Bstree{
        left: :leaf,
        right: %Bstree{
          left: :leaf,
          right: :leaf,
          data: 5
        },
        data: 1
      },
      right: %Bstree{
        left: :leaf,
        right: :leaf,
        data: 11
      },
      data: 10
    }
  end

  test "Traverse the tree inorder" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(1) |>
    Bstree.insert(5) |>
    Bstree.insert(4) |>
    Bstree.insert(12)

    assert Bstree.traverse(tree) == [1,4,5,10,11,12]
  end

  test "Checks if the data present in the node" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(1) |>
    Bstree.insert(5) |>
    Bstree.insert(4) |>
    Bstree.insert(12)
    assert Bstree.exists?(tree, 4) == true
  end

  test "Deletes a data node no leaf nodes" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(1) |>
    Bstree.insert(5) |>
    Bstree.delete(5)
    assert Bstree.traverse(tree) == [1,10,11]
  end

  test "Deletes a data node with left node and a leaf nodes" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(5) |>
    Bstree.insert(4) |>
    Bstree.delete(5)
    assert Bstree.traverse(tree) == [4,10,11]
  end

  test "Deletes a data node with right node and a leaf nodes" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(5) |>
    Bstree.insert(6) |>
    Bstree.delete(5)
    assert Bstree.traverse(tree) == [6,10,11]
  end

  test "Deletes a data node with both left and right nodes" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(5) |>
    Bstree.insert(6) |>
    Bstree.insert(4) |>
    Bstree.delete(5)
    assert Bstree.traverse(tree) == [4,6,10,11]
  end

  test "Deletes a data node with both left and right subtrees" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(5) |>
    Bstree.insert(4) |>
    Bstree.insert(8) |>
    Bstree.insert(6) |>
    Bstree.insert(9) |>
    Bstree.delete(5)
    assert Bstree.traverse(tree) == [4, 6, 8, 9, 10, 11]
  end

  test "Deletes the root node" do
    tree = Bstree.new(10) |>
    Bstree.insert(11) |>
    Bstree.insert(1) |>
    Bstree.insert(5) |>
    Bstree.insert(4) |>
    Bstree.insert(12) |>
    Bstree.delete(10)
    assert Bstree.traverse(tree) == [1, 4, 5, 11, 12]
  end

end
