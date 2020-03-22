defmodule VersionHandler do
   # Based on https://github.com/goodcodein/goodcode.in/blob/master/elixir/a-simple-way-to-automatically-set-the-semantic-version-of-your-elixir-app.md
    def get_version do
        {git_desc, 0} = System.cmd("git", ~w[describe --always --tags])
        "v" <> major_minor = git_desc |> String.replace("\n", "")
        major_minor
    end

    # Based on https://github.com/tmbb/makeup/blob/master/scripts/release.exs
    @version_line_regex ~r/(\n\s*@version\s+")([^\n]+)("\n)/
    def set_version(version) do
        contents = File.read!("mix.exs")

        replaced =
        Regex.replace(@version_line_regex, contents, fn _, pre, _version, post ->
            "#{pre}#{version}#{post}"
        end)

        File.write!("mix.exs", replaced)
    end 
end

version = VersionHandler.get_version
VersionHandler.set_version(version)
