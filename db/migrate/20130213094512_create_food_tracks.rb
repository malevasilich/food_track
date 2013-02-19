class CreateFoodTracks < ActiveRecord::Migration
  def change
    create_table :food_tracks do |t|
      t.datetime :date
      t.float :weight

      t.timestamps
    end
  end
end
