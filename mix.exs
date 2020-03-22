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
      docs: &build_docs/1,
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
  defp get_version do
    case System.cmd("git", ~w[describe --always --tags]) do
      {git_desc, 0} ->
        "v" <> major_minor = git_desc |> String.replace("\n", "")
        major_minor

      _ ->
        "1.0.0"
    end
  end

  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed"
    end

    args = ["Makeup", get_version(), Mix.Project.compile_path()]
    opts = ~w[--main Makeup --source-ref v#{get_version()} --source-url #{@url}]
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end
end
