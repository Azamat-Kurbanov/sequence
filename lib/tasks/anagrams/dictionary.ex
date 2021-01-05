defmodule Dictionary do
  @name {:global, __MODULE__}

  ##
  # External API
  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def add_words(words) do
    Agent.update @name, &do_add_words(&1, words)
  end

  def anagrams_of(word) do
    Agent.get @name, &Map.get(&1, signature_of(word))
  end

  ##
  # Internal implementation
  def do_add_words(map, words) do
    Enum.reduce(words, map, &add_one_word(&1, &2))
  end

  defp add_one_word(word, map) do
    Map.update(map, signature_of(word), [word], &[word|&1])
  end

  defp signature_of(word) do
    word
    |> to_charlist()
    |> Enum.sort()
    |> to_string()
  end
end
