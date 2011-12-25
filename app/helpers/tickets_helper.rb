module TicketsHelper

  def upgrade_tickets
    Ticket.where(:upgrade => true).all.map { |ticket| [ticket.name, ticket.id] }
  end

end
