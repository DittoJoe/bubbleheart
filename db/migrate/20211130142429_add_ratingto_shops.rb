class AddRatingtoShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :rating, :float
  end
end
