class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :fname
      t.string :lname
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
