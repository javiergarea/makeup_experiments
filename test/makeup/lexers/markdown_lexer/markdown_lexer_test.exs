defmodule Makeup.Lexers.MarkdownLexer.MarkdownLexerTest do
    use ExUnit.Case
    alias Makeup.Lexers.MarkdownLexer

    doctest MarkdownLexer

    test "greets the world" do
        assert MarkdownLexer.hello() == :world
    end

end