#sucker_punch CreateWorker
class CreateWorker
  include SuckerPunch::Job

  def perform(food_track)
  	FitbitClient.instance.log_food(food_track.id)
  end
end