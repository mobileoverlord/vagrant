defmodule Vagrant.Cli do
  alias Vagrant.Message

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    for cmd <- [:destroy, :halt, :up, :reload, :status, :provision, :suspend, :resume, :ssh] do
      quote do
        def unquote(cmd)(opts \\ []) do
          execute(Atom.to_string(unquote(cmd)), opts)
        end
      end
    end
  end

  def vagrant(_, _ \\ [])
  def vagrant("ssh", opts) do
    flags = opts[:flags] || []
    command =
      Enum.find(flags, fn(flag) ->
        String.starts_with?(flag, "-c") or
        String.starts_with?(flag, "--command")
      end)
    if command != nil do
      execute("ssh", opts)
    end
  end

  def vagrant(cmd, opts), do: execute(cmd, opts)

  def execute(cmd, opts) do
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
