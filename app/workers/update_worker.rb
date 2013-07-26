#sucker_punch UpdateWorker
class UpdateWorker
  include SuckerPunch::Worker

  def perform(food_track)
  	FitbitClient.instance.update_foodlog(food_track.id)
  end
end