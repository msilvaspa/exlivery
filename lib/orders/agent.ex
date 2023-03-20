defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    id = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, order, id))
    {:ok, id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_order(&1, id))

  defp get_order(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  defp update_state(state, %Order{} = order, id), do: Map.put(state, id, order)
end
