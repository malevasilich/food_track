class Food < ActiveRecord::Base
	has_many :food_tracks
	validates_uniqueness_of :name, case_sensitive: false
	validates_presence_of :name
  	
  	attr_accessible :carb, :fat, :gi, :kkal, :name, :protein, :water
  	before_save :default_values

  	def default_values
  		self.carb ||= 0
  		self.fat ||= 0
  		self.gi ||= 0
  		self.kkal ||= 0
  		self.protein ||= 0
  		self.water ||= 0
  	end
end
