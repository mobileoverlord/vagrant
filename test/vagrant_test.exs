defmodule VagrantTest do
  use ExUnit.Case, async: false
  doctest Vagrant

  alias Vagrant.Message.Status

  require Logger

  setup_all do
    {:ok, [vagrantfile: "test/support/Vagrantfile"]}
  end

  test "vagrant up", opts do
    assert {:ok, _} = Vagrant.up opts
  end

  test "vagrant halt", opts do
    Vagrant.up opts
    assert {:ok, _} = Vagrant.halt opts
  end

  test "vagrant status", opts do
    Vagrant.up opts
    assert {:ok, %Status{state: :running}} = Vagrant.status opts
    Vagrant.halt opts
    assert {:ok, %Status{state: :poweroff}} = Vagrant.status opts
  end
end
