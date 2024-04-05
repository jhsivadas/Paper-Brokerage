class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.float :holdings
      t.float :cash
      t.integer :user_id

      t.timestamps
    end
  end
end
