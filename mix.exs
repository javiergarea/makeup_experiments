defmodule MakeupMarkdown.MixProject do
  use Mix.Project

  @url "https://github.com/javiergarea/makeup_markdown"

  def project do
    [
      app: :makeup_markdown,
      version: get_version(),
      elixir: "~> 1.10.2",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Makeup.Lexers.MarkdownLexer.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      "version.set": "run scripts/set_version.exs"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 1.0"},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end

  # Based on https://github.com/goodcodein/goodcode.in/blob/master/elixir/a-simple-way-to-automatically-set-the-semantic-version-of-your-elixir-app.md
  # and https://github.com/tmbb/makeup/blob/master/scripts/release.exs
  @version_regex ~r/v(\d+\.\d+\.\d+)/
  defp get_version do
    {git_desc, 0} = System.cmd("git", ~w[describe --always --tags])

    case Regex.run(@version_regex, git_desc) do
      [_line, version] -> version
      _ -> "1.0.0"
    end
  end
end
