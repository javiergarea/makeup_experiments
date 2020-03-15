defmodule CustomDataGen do
  use ExUnitProperties

  @heading_sharps ["#", "##", "###", "####", "#####", "######"]
  def heading_gen do
    ExUnitProperties.gen all(
                           title <- StreamData.string(:alphanumeric),
                           String.length(title) > 0,
                           heading_sharp <- StreamData.member_of(@heading_sharps)
                         ) do
      heading_sharp <> title <> "\n"
    end
  end
end
