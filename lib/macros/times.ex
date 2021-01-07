defmodule Times do
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(m), do: m * unquote(n)
    end
  end
end

defmodule TestTimes do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts TestTimes.times_3(4)
IO.puts TestTimes.times_4(5)
