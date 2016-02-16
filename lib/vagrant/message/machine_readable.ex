defmodule Vagrant.Message.MachineReadable do
  defstruct [timestamp: nil, target: "", type: "", data: nil]

  def load(data) do
    data
    |> String.strip
    |> String.split("\n")
    |> Enum.map(& String.split(&1, ","))
    |> Enum.reduce([], fn([timestamp, target, type, data | _tail], acc) ->
      {timestamp, _} = Integer.parse(timestamp)
      [%__MODULE__{
        timestamp: timestamp,
        target: target,
        type: type,
        data: data
      } | acc]
    end)
  end
end
