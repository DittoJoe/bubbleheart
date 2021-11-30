class AddKeysToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :key, :string
  end
end
