class AddCompletionToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :completion, :boolean
  end
end
