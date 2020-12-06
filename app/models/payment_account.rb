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
class PaymentAccount < ApplicationRecord
  belongs_to :user

  has_many :sent_payments, class_name: 'Payment', foreign_key: :sender_id,
                           inverse_of: :sender_id,
                           dependent: :destroy
  has_many :received_payments, class_name: 'Payment', foreign_key: :receiver_id,
                               inverse_of: :receiver_id,
                               dependent: :destroy

  def add_to_balance(amount)
    self.balance += amount
    save!
  end
end
