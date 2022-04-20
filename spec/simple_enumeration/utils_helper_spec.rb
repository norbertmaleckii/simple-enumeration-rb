# frozen_string_literal: true

RSpec.describe SimpleEnumeration::Utils do
  describe '.camelcase' do
    it { expect(described_class.camelcase('payment_status')).to eql('PaymentStatus') }
  end

  describe '.underscore' do
    it { expect(described_class.underscore('PaymentStatus')).to eql('payment_status') }
    it { expect(described_class.underscore('Payments::Status')).to eql('payments/status') }
    it { expect(described_class.underscore('ExternalUsers::Payments::Status')).to eql('external_users/payments/status') }
  end
end
