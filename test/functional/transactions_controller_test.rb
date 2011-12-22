require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase

  test "get index" do
    sign_in :user, users(:quentin)

    get :index
    assert_response :success
  end

end
