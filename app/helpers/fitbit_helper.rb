require 'singleton'
require 'fitgem'
require "yaml"
require "pp"

module FitbitHelper
end

	class FitbitClient
		include Singleton

		def initialize
			puts "init"
			# Load the existing yml config
			@config = Fitgem::Client.symbolize_keys(YAML.load(File.open("fitgem-sandbox/.fitgem.yml")))
			@client = Fitgem::Client.new(@config[:oauth])

			if @config[:oauth][:token] && @config[:oauth][:secret]
			    @access_token = @client.reconnect(@config[:oauth][:token], @config[:oauth][:secret])
			end
		end

		def log_food(food_track_id)
			ActiveRecord::Base.connection_pool.with_connection do
				puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
				ft = FoodTrack.find(food_track_id)
				puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
				
				fl = @client.log_food ({
				  foodId: 4982470,  # Ручной ввод калорий
				  mealTypeId: 7, #Anytime
				  unitId: 401, #cl
				  amount: ft.kcals,
				  date: Time.now.strftime("%Y-%m-%d")
				})
				puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

				puts ft

			    ft.update_attributes(fitbit_logid: fl["foodLog"]["logId"])

				puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
		    end
		end

		def delete_foodlog(food_track_id)
			ft = FoodTrack.find(food_track_id)
			@client.delete_logged_food(ft.fitbit_logid)
		end

		def update_foodlog(food_track_id)
			delete_foodlog(food_track_id)
			log_food(food_track_id)
		end
	end
