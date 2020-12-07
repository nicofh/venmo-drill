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
FactoryBot.define do
  factory :payment do
    amount      { Faker::Number.number(digits: 3) }
    description { Faker::TvShows::Friends.quote }
  end
end
