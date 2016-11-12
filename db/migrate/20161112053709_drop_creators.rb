class DropCreators < ActiveRecord::Migration[5.0]
  def change
    drop_table :creators
  end
end
