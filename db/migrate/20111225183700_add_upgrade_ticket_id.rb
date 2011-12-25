class AddUpgradeTicketId < ActiveRecord::Migration
  def up
    add_column :tickets, :upgrade_ticket_id, :integer
  end

  def down
    remove_column :tickets, :upgrade_ticket_id
  end
end
