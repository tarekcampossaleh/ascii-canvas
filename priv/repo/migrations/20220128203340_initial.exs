defmodule AsciiCanvas.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table("canvas") do
      add :value, {:array, :string}

      timestamps()
    end
  end
end
