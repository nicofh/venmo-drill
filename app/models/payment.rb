# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  receiver_id :bigint
#  sender_id   :bigint
#  amount      :float            not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payments_on_receiver_id  (receiver_id)
#  index_payments_on_sender_id    (sender_id)
#
class Payment < ApplicationRecord
  belongs_to :sender, class_name: 'PaymentAccount'
  belongs_to :receiver, class_name: 'PaymentAccount'

  validates :amount, numericality: { greater_than: 0, less_than: 1000 }
end
