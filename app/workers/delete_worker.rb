#sucker_punch DeleteWorker
class DeleteWorker
  include SuckerPunch::Worker

  def perform(food_track)
  	FitbitClient.instance.delete_foodlog(food_track.id)
  end
end