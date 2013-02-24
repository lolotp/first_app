require 'test_helper'

class GameUserControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get games" do
    get :games
    assert_response :success
  end

  test "should get game_status" do
    get :game_status
    assert_response :success
  end

  test "should get request_clue" do
    get :request_clue
    assert_response :success
  end

  test "should get clear_location" do
    get :clear_location
    assert_response :success
  end

end
