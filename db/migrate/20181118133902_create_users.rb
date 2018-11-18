class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.citext :email
      t.string :name
      t.string :password_digest
      t.string :access_token

      t.timestamps
    end

    add_index :users, [:email], unique: true
  end
end
