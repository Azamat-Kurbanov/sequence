defmodule Sequence.Server do
  use GenServer
  alias Sequence.Impl

  ### Exdternal API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(number) do
    GenServer.cast __MODULE__, {:increment_number, number}
  end

  ### GenServer implementation
  def init(_) do
    {:ok, Sequence.Stash.get}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, Impl.next(current_number)}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, Impl.increment(current_number, delta)}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update current_number
  end
end
