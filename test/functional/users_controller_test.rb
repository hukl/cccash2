require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase

  fixtures :users

  def setup
    sign_in :user, users(:quentin)
  end

  test "get index" do
    get :index
    assert_response :success
  end

  test "get new" do
    get :new
    assert_response :success
  end

  test "create new angel user" do
    assert_difference "User.count", +1 do
      post :create, :user => {
        :login                  => "peter",
        :name                   => "Peter",
        :password               => "foobar",
        :password_confirmation  => "foobar",
      }
    end
  end

  test "get show" do
    get :show, :id => 1
    assert_response :success
  end

  protected
    def create_user(options = {})
      post :create, :user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
