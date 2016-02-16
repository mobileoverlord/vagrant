defmodule Vagrant.Message do

  alias Vagrant.Message.MachineReadable
  alias Vagrant.Message.Status

  def parse(cmd, {:ok, result}) do
    result =
      try do
        mod = Module.concat(Vagrant.Message, String.capitalize(cmd))
        apply(mod, :load, [result])
      rescue
        _e -> result
      end
    {:ok, result}
  end

  def parse(_, {:error, result}) do
    {:error, MachineReadable.load(result)}
  end
end
