class AddFavoriteToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :favorite, :boolean
  end
end
