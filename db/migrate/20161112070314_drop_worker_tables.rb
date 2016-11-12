class DropWorkerTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :users_workers
    drop_table :workers
  end
end
