class DropCreatorUserJoin < ActiveRecord::Migration[5.0]
  def change
    drop_table :users_creators
  end
end
