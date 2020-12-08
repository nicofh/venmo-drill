# user1 is friends with user2, user2 with user3, and user3 with user4
# user1 pays to user2, user2 to user3, and user3 to user4
user1 = User.create!(email: 'user1@example.com', password: 'password',
                     first_name: 'John', last_name: 'Florence')
user1.payment_account.update!(balance: 3000)
ExternalPaymentSource.create!(user: user1, source_type: 'visa', account: '123456')

user2 = User.create!(email: 'user2@example.com', password: 'password',
                     first_name: 'Andy', last_name: 'Irons')
ExternalPaymentSource.create!(user: user2, source_type: 'mastercard', account: '654321')

user3 = User.create!(email: 'user3@example.com', password: 'password',
                     first_name: 'Kelly', last_name: 'Slater')
user3.payment_account.update!(balance: 1000)
ExternalPaymentSource.create!(user: user3, source_type: 'wells_fargo', account: '123456')

user4 = User.create!(email: 'user4@example.com', password: 'password',
                     first_name: 'Mason', last_name: 'Ho')
ExternalPaymentSource.create!(user: user4, source_type: 'visa', account: '234561')

Friendship.create!(first_friend: user1, second_friend: user2)
Friendship.create!(first_friend: user2, second_friend: user3)
Friendship.create!(first_friend: user3, second_friend: user4)

Payment.create!(sender: user1.payment_account, receiver: user2.payment_account, amount: 200)
Payment.create!(sender: user2.payment_account, receiver: user3.payment_account, amount: 400)
Payment.create!(sender: user3.payment_account, receiver: user4.payment_account, amount: 500)
Payment.create!(sender: user1.payment_account, receiver: user2.payment_account, amount: 200)
Payment.create!(sender: user2.payment_account, receiver: user3.payment_account, amount: 400)
Payment.create!(sender: user3.payment_account, receiver: user4.payment_account, amount: 999)
Payment.create!(sender: user1.payment_account, receiver: user2.payment_account, amount: 200)
Payment.create!(sender: user2.payment_account, receiver: user3.payment_account, amount: 400)
Payment.create!(sender: user3.payment_account, receiver: user4.payment_account, amount: 999)
Payment.create!(sender: user1.payment_account, receiver: user2.payment_account,
                amount: 200, description: 'this is a test')
Payment.create!(sender: user2.payment_account, receiver: user3.payment_account,
                amount: 400, description: 'thanks for the drinks')
Payment.create!(sender: user3.payment_account, receiver: user4.payment_account,
                amount: 1, description: 'last payment')
