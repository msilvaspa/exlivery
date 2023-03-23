defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "should creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected =
        "12345678909,pizza,1,12.99pizza,1,12.99,25.98\n" <>
          "12345678909,pizza,1,12.99pizza,1,12.99,25.98\n"

      Report.create("testing.csv")
      output = File.read!("testing.csv")
      assert output == expected
    end
  end
end
