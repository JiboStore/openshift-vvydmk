require 'test_helper'

class ScoredailyControllerTest < ActionController::TestCase
  test "should get save" do
    get :save
    assert_response :success
  end

  test "should get retrieve" do
    get :retrieve
    assert_response :success
  end

end
