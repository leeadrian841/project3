class RolifyCreateCreators < ActiveRecord::Migration
  def change
    create_table(:creators) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_creators, :id => false) do |t|
      t.references :user
      t.references :creator
    end

    add_index(:creators, :name)
    add_index(:creators, [ :name, :resource_type, :resource_id ])
    add_index(:users_creators, [ :user_id, :creator_id ])
  end
end
