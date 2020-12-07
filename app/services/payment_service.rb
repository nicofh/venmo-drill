class PaymentService
  attr_reader :user, :friend_id, :amount, :description

  def initialize(user, friend_id, amount, description)
    @user = user
    @friend_id = friend_id
    @amount = amount
    @description = description
  end

  def make_payment
    validate_friendship!
    validate_balance!
    create_payment(initialize_payment)
  end

  private

  def initialize_payment
    Payment.new(sender: user.payment_account,
                receiver: friend.payment_account,
                description: description,
                amount: amount)
  end

  def create_payment(payment)
    amount = payment.amount
    payment.transaction do
      payment.sender.add_to_balance(-amount)
      payment.receiver.add_to_balance(amount)
      payment.save!
    end
  end

  def validate_friendship!
    raise Payments::NotAFriendError unless user.friends.include?(friend)
  end

  def validate_balance!
    return unless user_balance < amount

    ExternalTransferService.new(user.external_payment_source, user.payment_account)
                           .transfer(amount - user_balance)
  end

  def friend
    User.find(friend_id)
  end

  def user_balance
    user.balance
  end
end
