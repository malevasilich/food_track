#!/usr/bin/env ruby
 
require "fitgem"
require "pp"
require "yaml"
require "date"

 
# Load the existing yml config
config = begin
  Fitgem::Client.symbolize_keys(YAML.load(File.open(".fitgem.yml")))
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
  exit
end
 
client = Fitgem::Client.new(config[:oauth])
 
# With the token and secret, we will try to use them
# to reconstitute a usable Fitgem::Client
if config[:oauth][:token] && config[:oauth][:secret]
  begin
    access_token = client.reconnect(config[:oauth][:token], config[:oauth][:secret])
  rescue Exception => e
    puts "Error: Could not reconnect Fitgem::Client due to invalid keys in .fitgem.yml"
    exit
  end
# Without the secret and token, initialize the Fitgem::Client
# and send the user to login and get a verifier token
else
  request_token = client.request_token
  token = request_token.token
  secret = request_token.secret
 
  puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below"
  verifier = gets.chomp
 
  begin
    access_token = client.authorize(token, secret, { :oauth_verifier => verifier })
  rescue Exception => e
    puts "Error: Could not authorize Fitgem::Client with supplied oauth verifier"
    exit
  end
 
  puts 'Verifier is: '+verifier
  puts "Token is:    "+access_token.token
  puts "Secret is:   "+access_token.secret
 
  user_id = client.user_info['user']['encodedId']
  puts "Current User is: "+user_id
 
  config[:oauth].merge!(:token => access_token.token, :secret => access_token.secret, :user_id => user_id)
 
  # Write the whole oauth token set back to the config file
  File.open(".fitgem.yml", "w") {|f| f.write(config.to_yaml) }
end
 
# ============================================================
# Add Fitgem API calls on the client object below this line
 
#pp client.activities_on_date 'today'


puts "date, weight, bf"
(1..30).each do |i|
  body_measurements = client.body_measurements_on_date( (Date.today - i).strftime('%Y-%m-%d') )
  #pp body_measurements
  puts "#{(Date.today - i+1).strftime('%Y-%m-%d')}, #{(body_measurements["body"]["weight"]*0.45359237).round(2)}, #{body_measurements["body"]["fat"]}"
end
