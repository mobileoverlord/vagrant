defmodule Vagrant.Error do
  defexception [:message]

  def not_installed do
    raise Vagrant.Error, message: "Vagrant is not installed or there is a problem calling the vagrant command"
  end
end
