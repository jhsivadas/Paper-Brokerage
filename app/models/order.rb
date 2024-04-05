# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  shares     :integer
#  ticker     :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#  user_id    :integer
#
class Order < ApplicationRecord
end
