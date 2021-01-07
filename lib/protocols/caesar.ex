defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_charlist
    |> Enum.map(&Char.shift(&1, shift))
    |> List.to_string
  end

  def rot13(string) do
    string
    |> String.to_charlist
    |> Enum.map(&Char.shift(&1, 13))
    |> List.to_string
  end
end

defimpl Caesar, for: List do
  def encrypt(list, shift) do
    list
    |> Enum.map(&Char.shift(&1, shift))
    |> List.to_string
  end

  def rot13(list) do
    list
    |> Enum.map(&Char.shift(&1, 13))
    |> List.to_string
  end
end

defmodule Char do
  def shift(char, shift) when char < 91 and char > 64 do
    case char + shift do
      new_char when new_char >= 91 -> new_char - 26
      new_char when new_char <= 64 -> new_char + 26
      new_char -> new_char
    end
  end

  def shift(char, shift) when char < 123 and char > 96 do
    case char + shift do
      new_char when new_char >= 123 -> new_char - 26
      new_char when new_char <= 96 -> new_char + 26
      new_char -> new_char
    end
  end

  def shift(char, _), do: char
end

defmodule CaesarTest do
  def test do
    words = "words.txt"
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(MapSet.new, fn(word, acc) -> MapSet.put(acc, word) end)

    words
    |> Enum.reduce([], fn(word, acc) -> update_results(word, words, acc) end)
  end

  def rotation_exists?(word, words) do
    rotated = Caesar.rot13(word)
    MapSet.member?(words, rotated)
  end

  def update_results(word, words, acc) do
    case rotation_exists?(word, words) do
      true -> [word | acc]
      false -> acc
    end
  end
end
