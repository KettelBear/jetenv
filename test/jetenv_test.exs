defmodule JetenvTest do
  use ExUnit.Case
  doctest Jetenv

  @genout [
    {"je__jetenv__string_data__long_text__S",
     "once upon a time\nthere were three bears\na momma bear\na papa bear\nand a baby bear\n"},
    {"je__jetenv__string_data__tabs__S", "this \t tab"},
    {"je__jetenv__string_data__quotes__S", "with \"quotes\""},
    {"je__jetenv__string_data__newlines2__S", "hello\n  there"},
    {"je__jetenv__string_data__newlines__S", "hello\nthere"},
    {"je__jetenv__string_data__simple__S", "hello"},
    {"je__jetenv__tuple_data__simple__U",
     "[{\"type\":\"M\",\"value\":\"MyApp\"},{\"type\":\"A\",\"value\":\"adam\"},{\"type\":\"S\",\"value\":\"my string\"},{\"type\":\"I\",\"value\":\"42\"},{\"type\":\"F\",\"value\":\"5.5\"},{\"type\":\"B\",\"value\":\"true\"}]"}
  ]

  test "generator" do
    out =
      Application.get_all_env(:jetenv)
      |> Jetenv.Encode.from_config(:jetenv, "je")

    assert @genout == out
  end

  test "decoder" do
    dec = Jetenv.load(@genout, prefix: "je")
    assert [jetenv: Application.get_all_env(:jetenv)] == dec
  end
end
