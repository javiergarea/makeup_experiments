defmodule Makeup.Lexers.MarkdownLexer.MarkdownLexerTest do
  use ExUnit.Case
  use ExUnitProperties
  alias Makeup.Lexers.MarkdownLexer

  doctest MarkdownLexer

  # property "lexes correctly texts" do
  #  check all(text <- CustomDataGen.text_gen()) do
  #    assert MarkdownLexer.lex(text) == [{:text, %{language: :markdown}, text}]
  #  end
  # end

  # property "lexes correctly headings" do
  #  check all(heading <- CustomDataGen.heading_gen()) do
  #    assert MarkdownLexer.lex(heading) == [{:generic_heading, %{language: :markdown}, heading}]
  #  end
  # end

  test "trivial" do
    assert 1 == 1
  end
end
