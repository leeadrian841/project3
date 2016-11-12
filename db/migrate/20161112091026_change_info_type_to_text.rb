class ChangeInfoTypeToText < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :info, :text
  end
end
