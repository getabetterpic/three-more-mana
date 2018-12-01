class CreateDeckCards < ActiveRecord::Migration[5.2]
  def change
    create_table :deck_cards do |t|
      t.references :deck, null: false
      t.references :card, null: false
      t.integer :card_count, default: 1

      t.timestamps
    end
  end
end
