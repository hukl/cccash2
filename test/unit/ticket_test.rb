require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  test "ticket must have a name" do
    assert_raise ActiveRecord::RecordInvalid do
      Ticket.create! :price => 0
    end
  end
  
  test "ticket must have a price" do
    assert_raise ActiveRecord::RecordInvalid do
      Ticket.create! :name => "foobar fnord"
    end
  end

  test "ticket price must be greater or equal than zero" do
    assert_raise ActiveRecord::RecordInvalid do
      Ticket.create! :name => "foobar fnord", :price => "x"
    end
  end

  test "ticket has ticket_sales method" do
    assert_nothing_raised { tickets(:one).ticket_sales }
  end
  
  test "ticket has transactions method" do
    assert_nothing_raised { tickets(:one).transactions }
  end
  
  test "has reservations association" do
    assert_nothing_raised { tickets(:one).reservations }
  end
  
  test "has special_guests association" do
    assert_nothing_raised { tickets(:one).special_guests }
  end

  test "one line for bon if price < 80" do
    ticket = Ticket.create! :price => 50, :name => 'Youngster'
    line = ticket.to_bon_line
    assert_match %r~^Youngster\s+50.00$~, line
  end
end
