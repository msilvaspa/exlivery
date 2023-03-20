defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "save/1" do
    test "should save the order" do
      order = build(:order)
      OrderAgent.start_link(%{})
      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "should return the order when found" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      output = OrderAgent.get(uuid)

      expected =
        {:ok,
         %Order{
           user_cpf: "12345678909",
           delivery_address: "rua das arvores",
           items: [
             %Item{
               description: "pizza de pedra",
               category: :pizza,
               unit_price: Decimal.new("12.99"),
               quantity: 1
             },
             %Item{
               description: "pizza de calabresa",
               category: :pizza,
               unit_price: Decimal.new("12.99"),
               quantity: 1
             }
           ],
           total_price: Decimal.new("25.98")
         }}

      assert output == expected
    end

    test "should return error when order not found" do
      output = OrderAgent.get("00000000000")
      expected = {:error, "Order not found"}
      assert output == expected
    end
  end
end
