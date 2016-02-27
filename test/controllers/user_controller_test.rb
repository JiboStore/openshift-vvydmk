require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get fblogin" do
    get :fblogin
    assert_response :success
  end

end
