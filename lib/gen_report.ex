defmodule GenReport do
  alias GenReport.Parser

  @users [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @years 2016..2020

  def build(), do: {:error, "Insira o nome de um arquivo"}

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(build_object_skeleton(), fn line, report -> do_sum(line, report) end)
  end

  defp do_sum([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = %{all_hours | name => all_hours[name] + hours}

    hours_per_month = update_in(hours_per_month, [name, month], &(&1 + hours))

    hours_per_year = update_in(hours_per_year, [name, year], &(&1 + hours))

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp build_object_skeleton() do
    %{
      "all_hours" => all_hours_start(),
      "hours_per_month" => hours_per_month_start(),
      "hours_per_year" => hours_per_year_start()
    }
  end

  defp all_hours_start() do
    Enum.into(@users, %{}, &{&1, 0})
  end

  defp hours_per_month_start() do
    Enum.into(@users, %{}, &{&1, all_months_start()})
  end

  defp hours_per_year_start() do
    Enum.into(@users, %{}, &{&1, all_years_start()})
  end

  defp all_months_start(), do: Enum.into(@months, %{}, &{&1, 0})

  defp all_years_start(), do: Enum.into(@years, %{}, &{&1, 0})
end
