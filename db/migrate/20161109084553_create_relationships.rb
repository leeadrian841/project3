class CreateRelationships < ActiveRecord::Migration[5.0]
    def change
        create_table :relationships do |t|
            t.integer :creator_user_id
            t.integer :acceptor_user_id, null: true
            t.integer :job_id

            t.timestamps
        end
    end
end
