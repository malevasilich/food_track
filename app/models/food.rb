class Food < ActiveRecord::Base
	has_many :food_tracks
  attr_accessible :carb, :fat, :gi, :kkal, :name, :protein, :water
end
