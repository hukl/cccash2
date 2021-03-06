require 'test_helper'

class SpecialGuestTest < ActiveSupport::TestCase

  test "special guest must have at least a name or uid" do
    assert_raise ActiveRecord::RecordInvalid do
      SpecialGuest.create!
    end
  end

  test "do not fail when only uuid is given" do
    SpecialGuest.create! :uid => "0xdeadbeef", :group_id => 1
  end

  test "do not fail when only name is given" do
    SpecialGuest.create! :name => "Fnord", :group_id => 1
  end

  test "do not fail when only forename is given" do
    SpecialGuest.create! :forename => "Fnord", :group_id => 1
  end

  test "when uid is present then uid must be unique unless it's blank" do
    assert_raise ActiveRecord::RecordInvalid do
      SpecialGuest.create! :uid => "blablub0xfnord"
    end
  end

  test "when uid is blank do not fail when there is another blank uid" do
    SpecialGuest.create! :name => "fnord1", :group_id => 1
    SpecialGuest.create! :name => "fnord2", :group_id => 1
  end

  test "has reservation association" do
    assert_nothing_raised { special_guests(:one).reservations }
  end

  test "has ticket throug reservation association" do
    assert_nothing_raised { special_guests(:one).tickets }
  end

  test "has group association" do
    assert_nothing_raised { special_guests(:one).group }
  end

  test "special guest must have an associated group" do
    special_guests = SpecialGuest.new
    assert special_guests.invalid?
    assert special_guests.invalid?(:group)
  end

  test "available tickets with standard first custom second" do
    user          = users(:aaron)
    workshift     = user.workshift
    special_guest = special_guests(:two)
    transaction   = Transaction.new :workshift => workshift, :special_guest_id => 2
    transaction.tickets << tickets(:one)
    transaction.tickets << tickets(:two)
    assert transaction.save

    assert_equal [tickets(:two)], special_guest.bought_tickets
    assert_equal [], special_guest.available_tickets
  end

  test "available tickets with custom first standard second" do
    user          = users(:aaron)
    workshift     = user.workshift
    special_guest = special_guests(:two)
    transaction   = Transaction.new :workshift => workshift, :special_guest_id => 2
    transaction.tickets << tickets(:two)
    transaction.tickets << tickets(:one)
    assert transaction.save

    assert_equal [tickets(:two)], special_guest.bought_tickets
    assert_equal [], special_guest.available_tickets
  end

end
