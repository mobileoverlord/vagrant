defmodule Vagrant.Ssh do
  require Logger

  def cmd(cmd, opts) do
    flags = opts[:flags] || []
    opts = opts
    |> Keyword.put(:flags, ["-c", cmd] ++ flags)
    Vagrant.Cli.execute("ssh", opts)
  end

  def session(_opts) do
    Logger.debug "Start SSH Session"
    {:ok, "Start SSH Session"}
  end
end
