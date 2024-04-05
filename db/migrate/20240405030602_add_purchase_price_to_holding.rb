class AddPurchasePriceToHolding < ActiveRecord::Migration[7.0]
  def change
    add_column :holdings, :purchase_price, :float
  end
end
