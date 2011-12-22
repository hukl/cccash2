$LOAD_PATH.unshift( File.join( Rails.root, "lib") )
require 'statistics'

class TicketSale < ActiveRecord::Base
  include Statistics

  belongs_to :transaction
  belongs_to :ticket

  validates_presence_of :ticket_id
end
