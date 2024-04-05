class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :ticker
      t.integer :shares
      t.string :type
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
