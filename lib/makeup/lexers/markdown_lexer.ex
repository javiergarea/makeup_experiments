defmodule Makeup.Lexers.MarkdownLexer do
  import NimbleParsec
  import Makeup.Lexer.Combinators
  import Makeup.Lexer.Groups

  @behaviour Makeup.Lexer

  # Combinators

  whitespace = ascii_string([?\s, ?\n, ?\f], min: 1) |> token(:whitespace)

  newlines =
    string("\n")
    |> optional(ascii_string([?\s, ?\n, ?\f], min: 1))
    |> token(:whitespace)

  any_char = utf8_char([]) |> token(:error)

  root_element_combinator =
    choice([
      whitespace,
      newlines,
      any_char
    ])

  # Embeding lexer
  @inline false

  @doc false
  def __as_markdown_language__({ttype, meta, value}) do
    {ttype, Map.put(meta, :language, :markdown), value}
  end

  @impl Makeup.Lexer
  defparsec(
    :root_element,
    root_element_combinator |> map({__MODULE__, :__as_markdown_language__, []}),
    inline: @inline
  )

  @impl Makeup.Lexer
  defparsec(
    :root,
    repeat(parsec(:root_element)),
    inline: @inline
  )

  # Postprocess tokens
  defp postprocess_helper([], result), do: result

  defp postprocess_helper([token | tokens], result),
    do: postprocess_helper(tokens, result ++ [token])

  @impl Makeup.Lexer
  def postprocess(tokens, _opts \\ []), do: postprocess_helper(tokens, [])

  @impl Makeup.Lexer
  defgroupmatcher(
    :match_groups,
    []
  )

  defp remove_initial_newline([{_ttype, _meta, "\n"} | tokens]), do: tokens

  defp remove_initial_newline([{ttype, meta, "\n" <> rest} | tokens]),
    do: [{ttype, meta, rest} | tokens]

  defp remove_initial_newline(tokens), do: tokens

  # Public API for the lexer
  @impl Makeup.Lexer
  def lex(text, _opts \\ []) do
    {:ok, tokens, "", _, _, _} = root("\n" <> text)

    tokens
    |> remove_initial_newline()
    |> postprocess()
  end
end
