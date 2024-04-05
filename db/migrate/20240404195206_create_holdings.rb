class CreateHoldings < ActiveRecord::Migration[7.0]
  def change
    create_table :holdings do |t|
      t.string :ticker
      t.integer :shares
      t.integer :account_id

      t.timestamps
    end
  end
end
