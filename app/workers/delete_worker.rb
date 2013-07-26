#sucker_punch DeleteWorker
class DeleteWorker
  include SuckerPunch::Job

  def perform(food_track)
  	FitbitClient.instance.delete_foodlog(food_track.id)
  end
end