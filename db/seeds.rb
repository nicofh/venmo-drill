# user1 and user2 created as friends
user1 = User.create!(email: 'user1@example.com', password: 'password')
user1.payment_account.update!(balance: 3000)
ExternalPaymentSource.create!(user: user1, source_type: 'visa', account: '123456')

user2 = User.create!(email: 'user2@example.com', password: 'password')
ExternalPaymentSource.create!(user: user2, source_type: 'mastercard', account: '654321')

Friendship.create!(first_friend: user1, second_friend: user2)
