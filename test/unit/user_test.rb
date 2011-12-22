require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  # def test_should_create_user
  #   assert_difference 'User.count' do
  #     user = create_user
  #     assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
  #   end
  # end

  # test "admin flag is false by default" do
  #   user = User.create! :login => "bernd", :name => "Bernd", :password => "foobar", :password_confirmation => "foobar"
  #   assert_equal false, user.admin?
  # end

  # test "destroying a user with workshifts should not work" do
  #   user = users(:quentin)
  #   assert_not_nil user.workshift
  #   assert_no_difference "User.count" do
  #     user.destroy
  #   end
  #   assert user.invalid?(:workshifts)
  # end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
