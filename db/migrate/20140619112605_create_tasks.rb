class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.string :text
      t.string :date_start
      t.string :date_end

      t.timestamps
    end
  end
end
