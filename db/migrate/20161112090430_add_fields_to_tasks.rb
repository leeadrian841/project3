class AddFieldsToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :info, :string
    add_column :tasks, :category, :string
    add_column :tasks, :location, :string
    add_column :tasks, :price, :float
  end
end
