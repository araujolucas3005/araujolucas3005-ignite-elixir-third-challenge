defmodule GenReport.Parser do
  @months %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_element([name, hours, days, month, year]),
    do: [
      name,
      String.to_integer(hours),
      String.to_integer(days),
      @months[month],
      String.to_integer(year)
    ]

  defp parse_line(line),
    do:
      line
      |> String.trim()
      |> String.downcase()
      |> String.split(",")
      |> parse_element()
end
