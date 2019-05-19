class AddResourceIdToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :resource_id, :string, null: false
    add_index :decks, [:resource_id], unique: true
  end
end
