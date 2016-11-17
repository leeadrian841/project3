class AddCompleteTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :completed_worker, :boolean
    add_column :tasks, :completed_creator, :boolean
  end
end
