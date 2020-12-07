# == Schema Information
#
# Table name: external_payment_sources
#
#  id          :bigint           not null, primary key
#  source_type :integer          default("wells_fargo"), not null
#  account     :integer          not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_external_payment_sources_on_user_id  (user_id)
#
FactoryBot.define do
  factory :external_payment_source do
    account       { Faker::Number.number(digits: 6) }
    source_type   { Faker::Number.between(from: 0, to: 2) }
    user
  end
end
