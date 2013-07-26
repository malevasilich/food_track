#! ruby

require 'fitbit_helper'

#create
FitbitClient.instance.log_food(FoodTrack.last.id)

#
FitbitClient.instance.delete_foodlog(FoodTrack.last.id)
	
#
FitbitClient.instance.update_foodlog(FoodTrack.last.id)

