defmodule Bstree do
  @moduledoc """
  Documentation for Bstree.
  """

  defstruct [:left, :right, :data]

  @doc """
  new tree.

  ## Examples

      iex> Bstree.new(10)
      %Bstree{left: :leaf, right: :leaf, data: 10}

  """
  def new(data) do
    %Bstree{left: :leaf, right: :leaf, data: data}
  end

  def insert(%Bstree{} = tree, data) do
     new_item = new(data)
     insert_item(tree, new_item)
  end

  def traverse(%Bstree{left: left, right: right, data: data} = _tree) do
    traverse(left) ++ [data] ++ traverse(right)
  end

  def traverse(:leaf), do: []

  def exists?(%Bstree{} = tree, data) do
    cond do
      tree.data == data -> true
      data < tree.data -> exists?(tree.left, data)
      data > tree.data -> exists?(tree.right, data)
    end
  end

  def exists?(:leaf, _data) do
    false
  end

  def delete(%Bstree{} = tree, data) do
    if exists?(tree, data) do
      delete_item(tree, data)
    end
  end

  def delete_item(%Bstree{} = tree, data) do
    cond do
      tree.data == data -> remove(tree)
      data < tree.data -> %Bstree{ tree | left: delete_item(tree.left, data) }
      data > tree.data -> %Bstree{ tree | right: delete_item(tree.right, data) }
    end
  end

  def remove(%Bstree{ left: :leaf, right: :leaf } = _tree), do: :leaf

  def remove(%Bstree{ left: :leaf, right: right } = _tree), do: right

  def remove(%Bstree{ left: left, right: :leaf } = _tree), do: left

  def remove(%Bstree{ left: left, right: right } = _tree) do
    succ = inorder_successor(right)
    %Bstree{ succ | left: left, right: delete(right, succ.data) }
  end

  def inorder_successor(tree) do
    if tree.left == :leaf do
      tree
    else
      inorder_successor(tree.left)
    end
  end

  defp insert_item(%Bstree{} = current_node, %Bstree{} = new_item) do
    if new_item.data <= current_node.data do
      %Bstree{ current_node | left: insert_item(current_node.left, new_item) }
    else
      %Bstree{ current_node | right: insert_item(current_node.right, new_item) }
    end
  end

  defp insert_item(:leaf, %Bstree{} = new_item) do
    new_item
  end
end
