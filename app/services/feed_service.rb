class FeedService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def feed
    user_ids = [user.id] + user.friends.pluck(:id)

    Payment.related_to(user_ids)
  end
end
