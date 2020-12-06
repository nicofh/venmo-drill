describe ExternalTransferService do
  describe '.transfer' do
    let!(:user)                     { create(:user) }
    let!(:external_payment_source)  { create(:external_payment_source, user: user) }
    let!(:amount)                   { 200 }

    subject { described_class.new(external_payment_source, user.payment_account).transfer(amount) }

    context 'when user has $0 in balance and the transfer is valid' do
      it 'adds amount to balance' do
        expect { subject }.to change { user.payment_account.reload.balance }.from(0).to(200)
      end
    end
  end
end
