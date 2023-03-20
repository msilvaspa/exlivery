defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item
  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_, _), do: {:error, "invalid parameters"}

  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{unit_price: price, quantity: qtd}, acc) do
    price
    |> Decimal.mult(qtd)
    |> Decimal.add(acc)
  end
end
