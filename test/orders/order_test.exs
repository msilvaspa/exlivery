defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "should create an order successfully" do
      user = build(:user)

      items = [
        build(:item),
        build(:item, description: "pizza de calabresa")
      ]

      output = Order.build(user, items)
      expected = {:ok, build(:order)}
      assert output == expected
    end

    test "should return error when no items" do
      user = build(:user)

      items = []

      output = Order.build(user, items)
      expected = {:error, "invalid parameters"}
      assert output == expected
    end

    test "should return error when no user" do
      user = nil

      items = [
        build(:item),
        build(:item, description: "pizza de calabresa")
      ]

      output = Order.build(user, items)
      expected = {:error, "invalid parameters"}
      assert output == expected
    end
  end
end
