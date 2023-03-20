defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "call/1" do
    setup do
      cpf = "12345678909"
      user = build(:user, cpf: cpf)
      Exlivery.start_agents()
      UserAgent.save(user)

      item1 = %{category: :pizza, description: "pizza de nozes", quantity: 1, unit_price: "12.34"}

      item2 = %{
        category: :pizza,
        description: "pizza de castanha",
        quantity: 1,
        unit_price: "21.43"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "should save the order when params are valid", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      input = %{user_cpf: cpf, items: [item1, item2]}

      output = CreateOrUpdate.call(input)

      assert {:ok, _uuid} = output
    end

    test "should return error when receives no quantity in item", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      input = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      output = CreateOrUpdate.call(input)
      expected = {:error, "Invalid items"}

      assert output == expected
    end

    test "should return error when receives empty items list", %{
      user_cpf: cpf
    } do
      input = %{user_cpf: cpf, items: []}

      output = CreateOrUpdate.call(input)
      expected = {:error, "invalid parameters"}

      assert output == expected
    end
  end
end
