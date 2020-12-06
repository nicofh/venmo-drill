# == Schema Information
#
# Table name: friendships
#
#  id               :bigint           not null, primary key
#  first_friend_id  :bigint
#  second_friend_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_friendships_on_first_friend_id   (first_friend_id)
#  index_friendships_on_second_friend_id  (second_friend_id)
#
class Friendship < ApplicationRecord
  belongs_to :first_friend, class_name: 'User'
  belongs_to :second_friend, class_name: 'User'

  validate :friendship_already_exists, on: :create

  scope :friendships_of, lambda { |user|
    where(first_friend: user).or(where(second_friend: user))
  }

  private

  def friendship_already_exists
    friendship_exists = Friendship.where(first_friend: first_friend, second_friend: second_friend)
                                  .or(Friendship.where(first_friend: second_friend,
                                                       second_friend: first_friend))
                                  .exists?

    return unless friendship_exists

    errors.add(:base, I18n.t('model.friendship.error.already_exists'))
  end
end
