defmodule Makeup.Lexers.MarkdownLexer.MarkdownLexerTest do
  use ExUnit.Case
  use ExUnitProperties
  alias Makeup.Lexers.MarkdownLexer

  doctest MarkdownLexer

  property "lexes correctly headings" do
    check all(heading <- CustomDataGen.heading_gen()) do
      assert MarkdownLexer.lex(heading) == [{:generic_heading, %{language: :markdown}, heading}]
    end
  end
end
