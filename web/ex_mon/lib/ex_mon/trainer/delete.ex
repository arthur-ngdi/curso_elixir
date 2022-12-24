defmodule ExMon.Trainer.Delete do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete_trainer(uuid)
    end
  end

  defp delete_trainer(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found"}
      trainer -> Repo.delete(trainer)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
