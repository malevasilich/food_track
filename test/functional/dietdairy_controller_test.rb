require 'test_helper'

class DietdairyControllerTest < ActionController::TestCase

	def setup
		login_as_user
	end

  test "should get show" do
    get :show
    assert_response :success
  end

end
