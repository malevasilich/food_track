require 'test_helper'

class FoodTracksControllerTest < ActionController::TestCase
  setup do
    @food_track = food_tracks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_track" do
    assert_difference('FoodTrack.count') do
      post :create, food_track: { date: @food_track.date, weight: @food_track.weight }
    end

    assert_redirected_to food_tracks_path
  end

  test "should show food_track" do
    get :show, id: @food_track
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_track
    assert_response :success
  end

  test "should update food_track" do
    put :update, id: @food_track, food_track: { date: @food_track.date, weight: @food_track.weight }
    assert_redirected_to food_track_path(assigns(:food_track))
  end

  test "should destroy food_track" do
    assert_difference('FoodTrack.count', -1) do
      delete :destroy, id: @food_track
    end

    assert_redirected_to food_tracks_path
  end
end
