# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  encrypted_password :string           default(""), not null
#  first_name         :string           default("")
#  last_name          :string           default("")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  provider           :string           default("email"), not null
#  uid                :string           default(""), not null
#  tokens             :json
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :external_payment_source, dependent: :destroy
  has_one :payment_account, dependent: :destroy

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: :first_friend_id,
                              inverse_of: :first_friend,
                              dependent: :destroy
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :second_friend_id,
                                  inverse_of: :second_friend,
                                  dependent: :destroy
  has_many :sent_friends, through: :sent_friendships, source: :second_friend
  has_many :received_friends, through: :received_friendships, source: :first_friend

  validates :uid, uniqueness: { scope: :provider }

  before_validation :init_uid
  after_commit :create_payment_account

  delegate :balance, to: :payment_account

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_social_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  def friends
    sent_friends + received_friends
  end

  private

  def create_payment_account
    self.payment_account = PaymentAccount.create!(user: self)
  end

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
