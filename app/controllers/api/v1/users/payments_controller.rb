module Api
  module V1
    module Users
      class PaymentsController < Api::V1::ApiController
        def create
          PaymentService.new(current_user, friend_id, amount, description).make_payment
          head :ok
        end

        private

        def friend_id
          params.require(:friend_id)
        end

        def amount
          params.require(:amount).to_f
        end

        def description
          params.require(:description)
        end
      end
    end
  end
end
