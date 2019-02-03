class AddMainboardToDeckCard < ActiveRecord::Migration[5.2]
  def change
    add_column :deck_cards, :mainboard, :boolean, null: false, default: true
  end
end
