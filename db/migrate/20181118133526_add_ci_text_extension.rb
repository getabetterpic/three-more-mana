class AddCiTextExtension < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext'
  end
end
