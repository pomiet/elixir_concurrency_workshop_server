defmodule ElixirConcurrencyWorkshop.Mixfile do
  use Mix.Project

  def project do
    [
      app: :lock,
      apps_path: "apps",
      version: "0.0.1",
      escript: escript(),
      deps: deps()
    ]
  end

  def escript do
    [main_module: LockedProcess.Application]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:mix_test_watch, "~> 0.5.0"}
    ]
  end
end
