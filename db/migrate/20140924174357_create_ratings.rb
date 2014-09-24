class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.boolean :success

      t.timestamps
    end
  end
end
