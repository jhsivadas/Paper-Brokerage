# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  cash       :float
#  holdings   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Account < ApplicationRecord
end
