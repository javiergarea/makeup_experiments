defmodule MakeupMarkdown.MixProject do
  use Mix.Project

  @version "1.1.1"
  @url "https://github.com/javiergarea/makeup_markdown"

  def project do
    [
      app: :makeup_markdown,
      version: @version,
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

  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed"
    end

    args = ["Makeup", @version, Mix.Project.compile_path()]
    opts = ~w[--main Makeup --source-ref v#{@version} --source-url #{@url}]
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end
end
