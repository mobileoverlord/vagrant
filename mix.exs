defmodule Vagrant.Mixfile do
  use Mix.Project

  def project do
    [app: :vagrant,
     version: "0.0.2-dev",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: []]
  end

  defp deps do
    []
  end

  defp description do
    """
    Vagrant CLI Wrapper
    """
  end

  defp package do
    [maintainers: ["Justin Schneck"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/mobileoverlord/vagrant"}]
  end
end
