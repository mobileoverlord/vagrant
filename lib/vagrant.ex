defmodule Vagrant do
  use Vagrant.Cli

  def installed? do
    try do
      System.cmd("vagrant", ["--version"])
      true
    rescue
      _e -> false
    end
  end

  def version do
    try do
      case System.cmd("vagrant", ["--version"]) do
        {result, 0} ->
          String.strip(result)
          |> String.split(" ")
          |> List.last
        _ ->
          Vagrant.Error.not_installed
      end
    rescue
      _e -> Vagrant.Error.not_installed
    end
  end
end
