$LOAD_PATH.unshift(File.join(Rails.root, "lib"))
require 'statistics'

class Transaction < ActiveRecord::Base
  include Statistics

  has_many    :ticket_sales
  has_many    :tickets,      :through => :ticket_sales
  belongs_to  :workshift
  belongs_to  :special_guest
  has_many    :bons

  validates_presence_of :tickets, :message => "You must sell something!"
  validates_presence_of :workshift

  validate :transaction_contains_only_one_custom_ticket, :transaction_contains_only_one_presale_ticket

  def grouped_tickets
    stats = {}

    tickets.flatten.each do |tick|
      stats[tick.id]            ||= {}
      stats[tick.id][:ticket]   ||= tick.name
      stats[tick.id][:total]    ||= 0
      stats[tick.id][:sum]      ||= 0
      stats[tick.id][:canceled] ||= 0
      stats[tick.id][:valid]    ||= 0
      stats[tick.id][(canceled? ? :canceled : :valid)] += 1
      stats[tick.id][:total]    += 1
      stats[tick.id][:sum]      += tick.price
    end

    stats
  end

  def transaction_contains_only_one_custom_ticket
    if 1 < self.tickets.custom.count
      errors.add(:base, "Only one custom ticket per transaction allowed")
    end
  end

  def transaction_contains_only_one_presale_ticket
    if 1 < self.tickets.presale.count
      errors.add(:base, "Only one presale ticket per transaction allowed")
    end
  end

  def total
    tickets.inject(0) {|sum, ticket| sum += ticket.price}
  end

  def presale
    self.tickets.each do |ticket|
      if ticket.presale? then
        return true
      end

        return false
    end
  end

  def cancel
    self.update_attributes(:canceled => true)
  end

  def total_mwst
    Mwst.included_in total
  end

  # 2011-08-06
  # Ticketpreis (Standard- und Businessticket) für Abendkasse muss in zwei Beträge aufgeteilt werden:
  #
  #   - Infrastrukturbeteiligung: 67.23 EUR netto (+ 19% MwSt. => 80 EUR)
  #   - Rest:
  #	     Standard 79.83 EUR netto (+ 19% MwSt. => 95 EUR)
  #	     Business  647.06 EUR netto (+ 19% MwSt. => 770 EUR)
  #
  #	   Für beide Beträge muß jeweils ein ordentlicher Beleg ausgestellt werden, also zwei Kassenbons pro Ticket.
  #
  #	   Unter-18-Tickets gehen wie gehabt mit einem.

  BonSplitAt = 80

  def print_bon!
    new_bons = tickets.map do |ticket|
      if ticket.price > BonSplitAt
        ticket_infra = returning(ticket.clone_temp) do |t|
          t.price = BonSplitAt
          t.name << " (Infrastruktur)"
        end
        ticket_rest = returning(ticket.clone_temp) do |t|
          t.price = ticket.price - ticket_infra.price
          t.name << " (Rest)"
        end
        [
          bons.create!(:ticket => ticket_infra),
          bons.create!(:ticket => ticket_rest)
        ]
      else
        bons.create!(:ticket => ticket)
      end
    end.flatten
    new_bons.each(&:print!)
    return new_bons
  end

end
