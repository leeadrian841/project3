class AddDefaultValueToShowAttribute < ActiveRecord::Migration[5.0]
  def change
  change_column :tasks, :completed_worker, :boolean, :default => false
  end

  def change
  change_column :tasks, :completed_creator, :boolean, :default => false
  end
end
