# == Schema Information
#
# Table name: holdings
#
#  id             :integer          not null, primary key
#  purchase_price :float
#  shares         :integer
#  ticker         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :integer
#
class Holding < ApplicationRecord
end
