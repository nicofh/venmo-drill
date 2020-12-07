describe PaymentService do
  describe '.make_payment' do
    let!(:user)                     { create(:user) }
    let!(:friend)                   { create(:user) }
    let!(:not_friend)               { create(:user) }
    let!(:external_payment_source)  { create(:external_payment_source, user: user) }
    let!(:amount)                   { 200 }
    let(:description)               { 'this is a test' }
    let!(:friendship) do
      create(:friendship, first_friend: user, second_friend: friend)
    end

    subject { described_class.new(user, friend.id, amount, description).make_payment }

    context 'when user transfers to a friend' do
      context 'user has enough balance' do
        before do
          user.payment_account.add_to_balance(amount)
        end

        it 'deducts amount to user' do
          expect { subject }.to change { user.payment_account.reload.balance }.from(200).to(0)
        end
        it 'adds amount to friend' do
          expect { subject }.to change { friend.payment_account.reload.balance }.from(0).to(200)
        end
      end

      context 'user has $0 balance' do
        it 'transfers from external payment source' do
          expect_any_instance_of(ExternalTransferService).to receive(:transfer).with(200)
          subject
        end

        it 'adds amount to friend' do
          expect { subject }.to change { friend.payment_account.reload.balance }.from(0).to(200)
        end
      end

      context 'user transfers 0 or less' do
        let!(:amount) { 0 }

        it 'raises validation error' do
          expect { subject }.to  raise_error(ActiveRecord::RecordInvalid,
                                             'Validation failed: Amount must be greater than 0')
        end
      end

      context 'user transfers 0' do
        let!(:amount) { 0 }

        it 'raises validation error' do
          expect { subject }.to  raise_error(ActiveRecord::RecordInvalid,
                                             'Validation failed: Amount must be greater than 0')
        end
      end

      context 'user transfers negative amount' do
        let!(:amount) { -200 }

        it 'raises validation error' do
          expect { subject }.to  raise_error(ActiveRecord::RecordInvalid,
                                             'Validation failed: Amount must be greater than 0')
        end
      end

      context 'user transfers 1000 or more' do
        let!(:amount) { 1001 }

        it 'raises validation error' do
          expect { subject }.to  raise_error(ActiveRecord::RecordInvalid,
                                             'Validation failed: Amount must be less than 1000')
        end
      end
    end

    context 'when user transfers to a not-friend user' do
      subject { described_class.new(user, not_friend.id, amount, description).make_payment }

      it 'raises NotAFriendError' do
        expect { subject }.to raise_error(Payments::NotAFriendError)
      end
    end
  end
end
