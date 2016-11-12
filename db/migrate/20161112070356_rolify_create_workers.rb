class RolifyCreateWorkers < ActiveRecord::Migration
  def change
    create_table(:workers) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_workers, :id => false) do |t|
      t.references :user
      t.references :worker
    end

    add_index(:workers, :name)
    add_index(:workers, [ :name, :resource_type, :resource_id ])
    add_index(:users_workers, [ :user_id, :worker_id ])
  end
end
