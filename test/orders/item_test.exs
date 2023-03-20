defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "should create an Item when provided valid input" do
      output = Item.build("pizza de pedra", :pizza, "12.99", 1)

      expected = {:ok, build(:item)}

      assert output == expected
    end

    test "should return error when invalid category is provided" do
      output = Item.build("pizza de pedra", :pastel, "12.99", 1)

      expected = {:error, "invalid input"}

      assert output == expected
    end

    test "should return error when quantiy < 1" do
      output = Item.build("pizza de pedra", :pizza, "12.99", 0)

      expected = {:error, "invalid input"}

      assert output == expected
    end

    test "should return error when invalid price is provided" do
      output = Item.build("pizza de pedra", :pizza, "invalid_price", 0)

      expected = {:error, "invalid input"}

      assert output == expected
    end
  end
end
