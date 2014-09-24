class AddSafetyToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :safety, :boolean
  end
end
