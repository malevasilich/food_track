class FoodTrack < ActiveRecord::Base
	belongs_to :food
  	attr_accessible :date, :weight, :food_id, :food_name	
  	before_save :init_data
  
  def init_data
    self.date ||= Time.now
  end

end
