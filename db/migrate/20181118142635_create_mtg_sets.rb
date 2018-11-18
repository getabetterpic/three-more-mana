class CreateMtgSets < ActiveRecord::Migration[5.2]
  def change
    create_table :mtg_sets do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :set_type
      t.integer :card_count
      t.string :parent_set_code
      t.date :released_at
      t.string :block_code
      t.string :block

      t.timestamps
    end

    add_index :mtg_sets, [:code], unique: true
  end
end
