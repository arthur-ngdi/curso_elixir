defmodule ExMon.Trainer.Get do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> fetch_trainer(uuid)
    end
  end

  defp fetch_trainer(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Trainer not found"}
      trainer -> {:ok, trainer}
    end
  end
end
