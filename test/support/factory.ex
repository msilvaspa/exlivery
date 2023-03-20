defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "esquilo",
      address: "rua das arvores",
      age: 27,
      cpf: "12345678909",
      email: "esquilo@domain.com"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "pizza de pedra",
      quantity: 1,
      unit_price: Decimal.new("12.99")
    }
  end

  def order_factory do
    %Order{
      user_cpf: "12345678909",
      delivery_address: "rua das arvores",
      items: [
        build(:item),
        %Item{
          description: "pizza de calabresa",
          category: :pizza,
          unit_price: Decimal.new("12.99"),
          quantity: 1
        }
      ],
      total_price: Decimal.new("25.98")
    }
  end
end
