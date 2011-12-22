class CreateBons < ActiveRecord::Migration
  def change
    create_table :bons do |t|
      t.integer :ticket_id
      t.integer :transaction_id

      t.timestamps
    end
  end
end
