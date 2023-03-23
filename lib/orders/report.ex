defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(filename \\ "report.csv") do
    order_list = build_order_list()
    File.write(filename, order_list)
  end

  defp build_order_list() do
    OrderAgent.list_all()
    |> Map.values()
    |> Enum.map(&order_string(&1))
    # |> Enum.map(fn order -> order_string(order) end)
    |> IO.inspect()
  end

  defp order_string(%Order{
         user_cpf: cpf,
         total_price: price,
         items: items
       }) do
    items_string =
      items
      |> Enum.map(&item_string(&1))

    "#{cpf},#{items_string},#{price}\n"
  end

  defp item_string(%Item{
         category: category,
         quantity: quantity,
         unit_price: price
       }) do
    "#{category},#{quantity},#{price}"
  end
end
