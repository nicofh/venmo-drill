# == Schema Information
#
# Table name: payment_accounts
#
#  id         :bigint           not null, primary key
#  balance    :float            default(0.0), not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payment_accounts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe PaymentAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
