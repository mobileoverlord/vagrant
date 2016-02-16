defmodule Vagrant.Message.Status do
  defstruct [state_long: nil, state: nil, provider: ""]

  alias Vagrant.Message.MachineReadable

  def load(data) when is_binary(data) do
    data
    |> MachineReadable.load
    |> __MODULE__.load
  end

  def load(data) do
    parse(data, %__MODULE__{})
  end

  def parse([], result), do: result
  def parse([message | tail], result) do
    result = parse(message, result)
    parse(tail, result)
  end

  def parse(%MachineReadable{type: "state", data: data}, result),
    do: %{result | state: String.to_atom(data)}

  def parse(%MachineReadable{type: "state-long", data: data}, result),
    do: %{result | state_long: data}

  def parse(%MachineReadable{type: "provider-name", data: data}, result),
    do: %{result | provider: data}

  def parse(_, result), do: result

end
