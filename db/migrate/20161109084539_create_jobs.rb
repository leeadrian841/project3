class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :type
      t.text :description
      t.integer :price
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
