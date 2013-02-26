require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test name do
  	f = Food.new
  	assert f.invalid?
  	f.name = 'Apple'
  	assert f.valid?
  	assert_equal f.carb, 0
  end
end
