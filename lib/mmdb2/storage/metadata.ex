defmodule Geolix.Adapter.MMDB2.Storage.Metadata do
  @moduledoc false

  alias MMDB2Decoder.Metadata

  @name Geolix.Adapter.MMDB2.Names.storage(:metadata)

  @doc """
  Starts the metadata agent.
  """
  @spec start_link() :: Agent.on_start()
  def start_link, do: Agent.start_link(fn -> %{} end, name: @name)

  @doc """
  Fetches a metadata entry for a database.
  """
  @spec get(atom) :: Metadata.t() | nil
  def get(database) do
    Agent.get(@name, &Map.get(&1, database, nil))
  end

  @doc """
  Stores a set of metadata for a specific database.
  """
  @spec set(atom, Metadata.t() | nil) :: :ok
  def set(database, metadata) do
    Agent.update(@name, &Map.put(&1, database, metadata))
  end
end
