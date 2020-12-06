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
require 'rails_helper'

RSpec.describe ExternalPaymentSource, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
