class AddAcceptanceToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :acceptance, :boolean
  end
end
