class AddFitbitLogidToFoodTracks < ActiveRecord::Migration
  def up
    add_column :food_tracks, :fitbit_logid, :string
  end

  def down
    remove_column :food_tracks, :fitbit_logid
  end
end
