class CreateMtgCards < ActiveRecord::Migration[5.2]
  def change
    create_table :mtg_cards do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :layout
      t.boolean :hires_image
      t.jsonb :image_uris
      t.string :mana_cost
      t.decimal :cmc
      t.string :type_line
      t.string :oracle_text
      t.string :power
      t.string :toughness
      t.jsonb :colors
      t.jsonb :color_identity
      t.jsonb :legalities
      t.string :set_code, null: false
      t.string :rarity
      t.jsonb :card_faces

      t.timestamps
    end

    add_index :mtg_cards, [:uuid], unique: true
    add_index :mtg_cards, [:set_code]
  end
end
