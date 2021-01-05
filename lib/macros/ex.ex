defmodule MyMacro do
  defmacro macro(code) do
    IO.inspect code
    quote do
      IO.puts "Different code"
    end
  end
end
defmodule MyTest do
  require MyMacro
  MyMacro.macro(IO.puts("hello"))
end
