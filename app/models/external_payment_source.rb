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
class ExternalPaymentSource < ApplicationRecord
  enum source_type: { wells_fargo: 0, mastercard: 1, visa: 2 }

  belongs_to :user

  validates :account, uniqueness: { scope: :source_type }
end
