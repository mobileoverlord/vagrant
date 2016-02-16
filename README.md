# Vagrant

A Vagrant CLI wrapper for Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add vagrant to your list of dependencies in `mix.exs`:

        def deps do
          [{:vagrant, "~> 0.0.1"}]
        end

  2. Ensure vagrant is started before your application:

        def application do
          [applications: [:vagrant]]
        end

## Usage

`Vagrant` generally wraps the CLI for the vagrant command. For example, you can call vagrant up

```elixir
Vagrant.up
```

By default, all commands will look for the Vagrant file by traversing the previous dir until the first one it finds. Alternatively, you can pass options to point it to the right vagrant file.

```elixir
Vagrant.up vagrantfile: "test/support/Vagrantfile"
```

There may also be times when you want to pass the output of the underlying vagrant commands to an alternative output, like `:stdio`. You can also pass any flags to the command using `flags: []`

```elixir
Vagrant.up out: :stdio, flags: ["--debug"]
```

Commands are expected to return `{:ok | :error, result}` All return types are attempted to be parsed using the Vagrant Machine Readable format. Additionally, certain modules have enhanced structs for representing the machine readable data like `Vagrant.Message.Status`

```elixir
Vagrant.status
%Vagrant.Message.Status{state_long: "running", state: :running, provider: "virtualbox"}
```

### Currently Supported Commands
```elixir
[:destroy, :halt, :up, :reload, :status, :provision, :suspend, :resume, :ssh]
```
Any of these commands can be called on the `Vagrant` module
```elixir
Vagrant.reload
```

Certain commands require a more extensive interface, like SSH. You can initiate single ssh commands are wait for the results
```elixir
Vagrant.ssh flags: ["-c", "whoami"]
{:ok, "vagrant"}
# Or Use the Ssh Api
Vagrant.Ssh.cmd("whoami")
```
