defmodule VagrantTest do
  use ExUnit.Case, async: false
  doctest Vagrant

  alias Vagrant.Message.Status

  require Logger

  setup_all do
    {:ok, %{vagrant: [vagrantfile: "test/support/Vagrantfile"]}}
  end

  test "vagrant up", opts do
    assert {:ok, _} = Vagrant.up opts[:vagrant]
  end

  test "vagrant halt", opts do
    Vagrant.up opts[:vagrant]
    assert {:ok, _} = Vagrant.halt opts[:vagrant]
  end

  test "vagrant status", opts do
    Vagrant.up opts[:vagrant]
    assert {:ok, %Status{state: :running}} = Vagrant.status opts[:vagrant]
    Vagrant.halt opts[:vagrant]
    assert {:ok, %Status{state: :poweroff}} = Vagrant.status opts[:vagrant]
  end

  test "vagrant ssh command", opts do
    Vagrant.up opts[:vagrant]
    assert {:ok, "vagrant"} = Vagrant.ssh(Keyword.put(opts[:vagrant], :flags, ["-c", "whoami"]))
    assert {:ok, "vagrant"} = Vagrant.Ssh.cmd("whoami", opts[:vagrant])
  end
end
