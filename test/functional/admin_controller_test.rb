require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  def setup
    sign_in :user, users(:quentin)
  end

  test "get admin page" do
    get :index
    assert_response :success
  end

  test "angel should not be able to access admin controller" do
    sign_in :user, users(:aaron)
    get :index
    assert_response 401
  end
end
