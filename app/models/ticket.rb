class Ticket < ActiveRecord::Base

  has_many :ticket_sales
  has_many :transactions,   :through => :ticket_sales

  has_many :reservations
  has_many :special_guests, :through => :reservations

  validates_presence_of     :name,  :price
  validates_numericality_of :price, :greater_than_or_equal_to => 0

  scope :custom,      where('custom = true OR presale = true')
  scope :standard,    where(:custom => false, :presale => false)
  scope :presale,     where(:presale => true, :custom => false)
  scope :available,   lambda { where([
    "available_from < ? and ? < available_until", Time.now, Time.now
  ]) }

  acts_as_list

  def upgrade_ticket
    Ticket.find( upgrade_ticket_id )
  rescue
    nil
  end

  def to_bon_line
    single_bon_line
  end

  def sales_grouped_by_day(fmt='%d', shift=6.hours)
    ticket_sales.group_by do |s|
      (s.transaction.created_at-shift).strftime(fmt)
    end
  end

  def count_sales_series(start_time, end_time, step)
    TicketSale.count_time_series :start => start_time,
                                 :end   => end_time,
                                 :step  => step,
                                 :conditions => { :ticket_id => self.id }
  end

  # clones this ticket and disabled saving. This is used to split up tickets for seperate printing of bons (see Transaction#print_bon)
  def clone_temp
    clone.tap do |c|
      def c.save(*a)
        true
      end
    end
  end

  private

  def single_bon_line
    ''.tap do |line|
      line << name_for_bon
      line << " " * ( Printer::BON_WIDTH - (price_for_bon.length + name_for_bon.length) )
      line << price_for_bon
    end
  end

  def price_for_bon
    @price_for_bon ||= sprintf('%.2f', price)
  end

  def name_for_bon
    @name_for_bon ||= name.convert_umlauts
  end
end
