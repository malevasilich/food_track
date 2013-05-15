class FoodTrack < ActiveRecord::Base
	belongs_to :food
  	attr_accessible :date, :weight, :food_id, :food_name	
    validates_presence_of :weight, :food_id
  	before_save :init_data
  
  def init_data
    self.date ||= Time.now
  end

  def kcals 
  	self.food.kkal/100*self.weight
  end

  def fats
  	self.food.fat/100*self.weight
  end

  def load_cluster
    dt = 0
    dt1 = self.date
    while dt1!=dt do
      dt = dt1
      dt1 = FoodTrack.where(:date => dt-60*60..dt).order('date').first.date
    end
    min_cluster_date = dt

    dt = 0
    dt1 = self.date
    while dt1!=dt do
      dt = dt1
      dt1 = FoodTrack.where(:date => dt..dt+60*60).order('date').last.date
    end
    max_cluster_date = dt

    FoodTrack.where(:date => min_cluster_date..max_cluster_date)
  end

  def cluster_kcals
    load_cluster.sum(&:kcals)
  end

end
