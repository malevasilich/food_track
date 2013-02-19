class AddFoodIdToFoodTrack < ActiveRecord::Migration
  def change
    add_column :food_tracks, :food_id, :integer
  end
end
