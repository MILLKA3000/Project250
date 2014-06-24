class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :role_id
      t.string :note

      t.timestamps
    end
  end
end
