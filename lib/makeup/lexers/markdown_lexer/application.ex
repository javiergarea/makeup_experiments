defmodule Makeup.Lexers.MarkdownLexer.Application do
  @moduledoc false
  use Application

  alias Makeup.Registry
  alias Makeup.Lexers.MarkdownLexer

  def start(_type, _args) do
    Registry.register_lexer(MarkdownLexer,
      options: [],
      names: ["markdown"],
      extensions: ["md"]
    )

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
