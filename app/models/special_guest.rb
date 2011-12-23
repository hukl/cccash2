class SpecialGuest < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,        :type => 'string',  :index    => :not_analyzed
    indexes :forename,  :type => 'string',  :analyzer => 'snowball'
    indexes :name,      :type => 'string',  :analyzer => 'snowball'
    indexes :uid,       :type => 'string',  :analyzer => 'keyword', :boost => 100
  end

  has_many    :reservations
  has_many    :tickets,       :through => :reservations
  has_many    :transactions
  belongs_to  :group

  validates_uniqueness_of   :uid,   :allow_blank => true
  validates_presence_of     :uid,   :if => Proc.new { |special_guest|
    # fail if all fields are blank
    special_guest.name.blank? and special_guest.forename.blank?
  }
  validates_presence_of     :group

  def assign_ticket options
    base_ticket   = Ticket.find(options[:base_ticket_id])
    price         = options[:price].to_i

    custom_ticket = find_or_create_custom_ticket(base_ticket, price)

    self.tickets << custom_ticket
  end

  def find_or_create_custom_ticket base_ticket, price
    custom_ticket = Ticket.find(
      :first,
      :conditions => {
        :custom => true,
        :name => base_ticket.name,
        :price => price
      }
    )

    unless custom_ticket
      custom_ticket = Ticket.create!(
        base_ticket.attributes.merge(:price => price, :custom => true)
      )
    end
    custom_ticket
  end

  def checked_in
    return (self.transactions.to_a.size > 0 || self.transactions.find_by_canceled(true).to_a.size > 1)
  end

  def bought_tickets
    tickets = self.transactions.map {|tr| tr.tickets.custom}
    tickets.flatten
  end

  def available_tickets
    available_tickets = tickets.available - bought_tickets.flatten
  end

end
