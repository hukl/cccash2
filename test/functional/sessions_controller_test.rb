require File.dirname(__FILE__) + '/../test_helper'
require 'sessions_controller'

# Re-raise errors caught by the controller.
class SessionsController; def rescue_action(e) raise e end; end

class SessionsControllerTest < ActionController::TestCase
  # fixtures :users

  # test "angels without workshift should not be able to login" do
  #   post :create, :login => 'yesper', :password => 'monkey'
  #   assert_nil session[:user_id]
  #   assert_response :success
  #   assert_template :new
  #   assert_equal "No workshift or workshift deactivated", flash[:notice]
  # end

  # test "angels without active workshift should not be able to login" do
  #   post :create, :login => 'melchior', :password => 'monkey'
  #   assert_nil session[:user_id]
  #   assert_response :success
  #   assert_template :new
  #   assert_equal "No workshift or workshift deactivated", flash[:notice]
  # end

  # test "angels with active workshift shoud set started_at properly" do
  #   post :create, :login => 'aaron', :password => 'monkey'
  #   assert session[:user_id]
  #   assert @controller.send(:logged_in?)
  #   assert_equal "Active", User.find(2).workshift.status
  # end

  # test "angels with active workshift should set ended_at on logout" do
  #   post  :create, :login => 'aaron', :password => 'monkey'
  #   get   :destroy
  #   assert_nil session[:user_id]
  #   assert_equal "Standby", User.find(2).workshift.status
  # end

  # def test_should_login_and_redirect
  #   post :create, :login => 'quentin', :password => 'monkey'
  #   assert session[:user_id]
  #   assert_response :redirect
  # end

  # def test_should_fail_login_and_not_redirect
  #   post :create, :login => 'quentin', :password => 'bad password'
  #   assert_nil session[:user_id]
  #   assert_response :success
  # end

  # def test_should_logout
  #   sign_in :quentin
  #   get :destroy
  #   assert_nil session[:user_id]
  #   assert_response :redirect
  # end

  # def test_should_remember_me
  #   @request.cookies["auth_token"] = nil
  #   post :create, :login => 'quentin', :password => 'monkey', :remember_me => "1"
  #   assert_not_nil @response.cookies["auth_token"]
  # end

  # def test_should_not_remember_me
  #   @request.cookies["auth_token"] = nil
  #   post :create, :login => 'quentin', :password => 'monkey', :remember_me => "0"
  #   # puts @response.cookies["auth_token"]
  #   assert @response.cookies["auth_token"].blank?
  # end

  # def test_should_delete_token_on_logout
  #   sign_in :quentin
  #   get :destroy
  #   assert @response.cookies["auth_token"].blank?
  # end

  # def test_should_login_with_cookie
  #   users(:quentin).remember_me
  #   @request.cookies["auth_token"] = cookie_for(:quentin)
  #   get :new
  #   assert @controller.send(:logged_in?)
  # end

  # def test_should_fail_expired_cookie_login
  #   users(:quentin).remember_me
  #   users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
  #   @request.cookies["auth_token"] = cookie_for(:quentin)
  #   get :new
  #   assert !@controller.send(:logged_in?)
  # end

  # def test_should_fail_cookie_login
  #   users(:quentin).remember_me
  #   @request.cookies["auth_token"] = auth_token('invalid_auth_token')
  #   get :new
  #   assert !@controller.send(:logged_in?)
  # end

  # protected
  #   def auth_token(token)
  #     CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  #   end

  #   def cookie_for(user)
  #     auth_token users(user).remember_token
  #   end
end
