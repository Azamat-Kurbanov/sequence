defmodule Times do
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(factor), do: factor * unquote(n)
    end
  end
end

defmodule TestMyMac do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts TestMyMac.times_3(4)
IO.puts TestMyMac.times_4(5)
