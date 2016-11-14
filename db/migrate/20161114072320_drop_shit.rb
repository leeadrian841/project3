class DropShit < ActiveRecord::Migration[5.0]
  def change
    drop_table :creators
    drop_table :jobs
    drop_table :offers
    drop_table :relationships
    drop_table :users_creators
    drop_table :users_workers
    drop_table :workers
    
  end
end
