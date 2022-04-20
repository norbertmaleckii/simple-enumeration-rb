# frozen_string_literal: true

RSpec.describe SimpleEnumeration::ObjectHelper do
  describe '.define_simple_enumeration' do
    context 'without class name' do
      subject(:order_class) do
        stub_const('PaymentStatusEnumeration', payment_status_class)

        Class.new do
          extend SimpleEnumeration::ObjectHelper

          define_simple_enumeration :payment_status

          attr_accessor :payment_status

          def initialize(payment_status:)
            @payment_status = payment_status
          end
        end
      end

      let(:payment_status_class) do
        Class.new(SimpleEnumeration::Entity) do
          define_basic_collection(
            :unpaid,
            :failed,
            :expired,
            completed: :paid
          )

          define_custom_collection(
            :finished,
            failed,
            expired,
            completed
          )
        end
      end

      it 'defines instance payments status enumeration method' do
        order = order_class.new(payment_status: 'paid')

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('completed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('paid')

        order.payment_status = 'failed'

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('failed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('failed')
      end
    end

    context 'with class name given as string' do
      subject(:order_class) do
        stub_const('PaymentStatusEnumeration', payment_status_class)

        Class.new do
          extend SimpleEnumeration::ObjectHelper

          define_simple_enumeration :payment_status, with: 'PaymentStatusEnumeration'

          attr_accessor :payment_status

          def initialize(payment_status:)
            @payment_status = payment_status
          end
        end
      end

      let(:payment_status_class) do
        Class.new(SimpleEnumeration::Entity) do
          define_basic_collection(
            :unpaid,
            :failed,
            :expired,
            completed: :paid
          )

          define_custom_collection(
            :finished,
            failed,
            expired,
            completed
          )
        end
      end

      it 'defines instance payments status enumeration method' do
        order = order_class.new(payment_status: 'paid')

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('completed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('paid')

        order.payment_status = 'failed'

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('failed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('failed')
      end
    end

    context 'with class name given as class' do
      subject(:order_class) do
        stub_const('PaymentStatusEnumeration', payment_status_class)

        Class.new do
          extend SimpleEnumeration::ObjectHelper

          define_simple_enumeration :payment_status, with: PaymentStatusEnumeration

          attr_accessor :payment_status

          def initialize(payment_status:)
            @payment_status = payment_status
          end
        end
      end

      let(:payment_status_class) do
        Class.new(SimpleEnumeration::Entity) do
          define_basic_collection(
            :unpaid,
            :failed,
            :expired,
            completed: :paid
          )

          define_custom_collection(
            :finished,
            failed,
            expired,
            completed
          )
        end
      end

      it 'defines instance payments status enumeration method' do
        order = order_class.new(payment_status: 'paid')

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('completed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('paid')

        order.payment_status = 'failed'

        expect(order.payment_status_enumeration).to be_a(PaymentStatusEnumeration)
        expect(order.payment_status_enumeration.type).to be_a(SimpleEnumeration::Type)
        expect(order.payment_status_enumeration.type.value).to eql('failed')
        expect(order.payment_status_enumeration.type.converted_value).to eql('failed')
      end
    end
  end
end
