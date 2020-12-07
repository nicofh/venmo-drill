describe FeedService do
  describe '.feed' do
    let!(:user1)        { create(:user) }
    let!(:user2)        { create(:user) }
    let!(:user3)        { create(:user) }
    let!(:user4)        { create(:user) }
    let!(:friendship1)  { create(:friendship, first_friend: user1, second_friend: user2) }
    let!(:friendship2)  { create(:friendship, first_friend: user2, second_friend: user3) }
    let!(:friendship3)  { create(:friendship, first_friend: user3, second_friend: user4) }
    let!(:payment1) do
      create(:payment, sender: user1.payment_account, receiver: user2.payment_account)
    end
    let!(:payment2) do
      create(:payment, sender: user2.payment_account, receiver: user3.payment_account)
    end
    let!(:payment3) do
      create(:payment, sender: user3.payment_account, receiver: user4.payment_account)
    end

    context 'when user1 is friend with and pays to user2,
             idem user2 to user3 and user3 to user4' do
      context 'when user1 sees feed' do
        subject { described_class.new(user1).feed }

        it 'shows user1 and user2 activity only' do
          expect(subject).to eq([payment2, payment1])
        end

        it 'does not shows user3 and user4 payment' do
          expect(subject).not_to include(payment3)
        end
      end

      context 'when user2 sees feed' do
        subject { described_class.new(user2).feed }

        it 'shows all activity' do
          expect(subject).to eq([payment3, payment2, payment1])
        end
      end
    end
  end
end
