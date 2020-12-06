module Payments
  class NotAFriendError < VenmoError
    def initialize(msg = I18n.t('api.errors.payment.not_a_friend'))
      super
    end
  end
end
