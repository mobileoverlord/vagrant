defmodule Vagrant do
  alias Vagrant.Cli

  defdelegate up, to: Cli
  defdelegate up(opts), to: Cli

  defdelegate halt, to: Cli
  defdelegate halt(opts), to: Cli

  defdelegate reload, to: Cli
  defdelegate reload(opts), to: Cli

  defdelegate status, to: Cli
  defdelegate status(opts), to: Cli
end
