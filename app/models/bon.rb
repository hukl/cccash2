# The Bon will just hold a record THAT a bon for a sold ticket was printed. We
# won't save the bon's content (privacy)
class Bon < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :ticket

  attr_accessor :billing_address

  def to_s
    to_printable
  end
  def to_printable
    @printable ||= generate
  end


  def print!
    Rails.logger.debug { ">> printing bon:\n#{self}" }
    transaction.workshift.cashbox.printer.print self
  end

  private
  def delimiter
    "\n"
  end

  def generate
    (
    [
      "CCCamp 2011".center(Printer::BON_WIDTH),
      "".center(Printer::BON_WIDTH),
      "Chaos Computer Club".center(Printer::BON_WIDTH),
      "Veranstaltungsgesellschaft mbH".center(Printer::BON_WIDTH),
      "Postfach 64 02 36".center(Printer::BON_WIDTH),
      "10048 Berlin\n".center(Printer::BON_WIDTH)
    ] +
      [transcode_billing_address(billing_address)] +
    [
      "\nTicket                                 EUR",
      "-" * Printer::BON_WIDTH,
      ticket.to_bon_line,
      "-" * Printer::BON_WIDTH,
      sprintf( '%s %.2f', 'enthaltene MwSt', Mwst.included_in(ticket.price)).rjust(Printer::BON_WIDTH),
      "=" * Printer::BON_WIDTH + "\n",
      "Leistungsdatum gleich Rechnungsdatum".center(Printer::BON_WIDTH),
      "Preise inkl. #{Mwst::Percent}% MwSt".center(Printer::BON_WIDTH),
      "VIELEN DANK!\n".center(Printer::BON_WIDTH),
      "AG Charlottenburg HRB 71629".center(Printer::BON_WIDTH),
      "USt-ID: DE203286729".center(Printer::BON_WIDTH),
      (Time.now.strftime('%d. %b %Y - %H:%M ') + transaction.workshift.cashbox.name).center(Printer::BON_WIDTH),
      ("Belegnummer: #{id}").center(Printer::BON_WIDTH)


    ]).flatten.compact.join(delimiter) +
    Printer::END_OF_BON
  end

  def transcode_billing_address address
    return if address.blank?
    address_lines = address.split(/\r\n/).collect {|l| "  " + l.convert_umlauts[0...Printer::BON_WIDTH-2]}

    (
      [ "Leistungsempfaenger:" ] +
      address_lines
    ).flatten.compact.collect {|line| line.ljust(Printer::BON_WIDTH)}
  end


end
