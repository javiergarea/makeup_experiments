defmodule MakeupMarkdown.MixProject do
  use Mix.Project

  def project do
    [
      app: :makeup_markdown,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger],
      extra_applications: [:stream_data]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 1.0"},
      {:stream_data, "~> 0.1", only: :test},
      {:credo, "~> 1.3", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end
end
