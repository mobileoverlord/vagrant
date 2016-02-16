defmodule Vagrant.Cli do
  alias Vagrant.Message

  def up(opts \\ []),
    do: vagrant("up", opts)

  def halt(opts \\ []),
    do: vagrant("halt", opts)

  def reload(opts \\ []),
    do: vagrant("reload", opts)

  def status(opts \\ []),
    do: vagrant("status", opts)

  def vagrant(cmd, opts \\ []) do
    opts = opts
    |> Enum.into(%{})

    wd = opts
    |> vagrantfile

    cmd_opts = [cd: wd]
    |> out(opts)

    flags = opts[:flags] || []

    result =
      case System.cmd("vagrant", [cmd, "--machine-readable"] ++ flags, cmd_opts) do
        {result,0} -> {:ok, result}
        {result, _} -> {:error, result}
      end

    cmd
    |> Message.parse(result)
  end

  defp vagrantfile(%{vagrantfile: file}), do: file |> Path.dirname
  defp vagrantfile(_), do: File.cwd! |> Path.dirname

  defp out(cmd_opts, %{out: :stdio}) do
    cmd_opts
    |> Keyword.put(:into, IO.stream(:stdio, :line))
    |> Keyword.put(:stderr_to_stdout, true)
  end
  defp out(cmd_opts, _), do: cmd_opts

end
