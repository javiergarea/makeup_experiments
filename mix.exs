defmodule MakeupMarkdown.MixProject do
  use Mix.Project

  def project do
    [
      app: :makeup_markdown,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      docs: &build_docs/1,
      release: "run scripts/release.exs"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Makeup.Lexers.MarkdownLexer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 1.0"},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end
end
