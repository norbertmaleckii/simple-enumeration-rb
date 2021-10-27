# frozen_string_literal: true

RSpec.describe SimpleEnumeration::Entity do
  describe '.define_basic_collection' do
    subject(:payment_status_class) do
      Class.new(described_class) do
        def self.name
          'PaymentStatus'
        end

        define_basic_collection(
          :unpaid,
          :failed,
          :expired,
          completed: :paid
        )
      end
    end

    it 'defines new singleton methods' do
      new_singleton_methods = payment_status_class.singleton_methods - Object.singleton_methods

      expect(new_singleton_methods).to match_array(
        %i[
          basic_collection
          failed
          basic_collection_values
          basic_collection_value?
          basic_collection_for_select
          basic_collection_humanized
          unpaid_value
          unpaid_value?
          failed_value
          failed_value?
          expired_value
          expired_value?
          completed_value
          completed_value?
          unpaid
          expired
          completed
          get_collection
          set_collection
          define_basic_collection
          define_custom_collection
          dry_initializer
          param
          option
          name
        ]
      )
    end

    it 'defines new instance methods' do
      new_instance_methods = payment_status_class.instance_methods - Object.instance_methods

      expect(new_instance_methods).to match_array(
        %i[
          failed_value?
          basic_collection_value?
          expired_value?
          completed_value?
          unpaid_value?
          type
          converted_value
        ]
      )
    end

    it 'defines singleton unpaid method' do
      expect(payment_status_class.unpaid).to be_a(SimpleEnumeration::Type)
      expect(payment_status_class.unpaid.value).to eql('unpaid')
      expect(payment_status_class.unpaid.converted_value).to eql('unpaid')
      expect(payment_status_class.unpaid.definition).to be(:unpaid)
      expect(payment_status_class.unpaid.enum_class).to eql(payment_status_class)
    end

    it 'defines singleton unpaid value method' do
      expect(payment_status_class.unpaid_value).to eql('unpaid')
    end

    it 'defines singleton unpaid value predicate method' do
      expect(payment_status_class.unpaid_value?('unpaid')).to be(true)
      expect(payment_status_class.unpaid_value?('invalid')).to be(false)
    end

    it 'defines singleton failed method' do
      expect(payment_status_class.failed).to be_a(SimpleEnumeration::Type)
      expect(payment_status_class.failed.value).to eql('failed')
      expect(payment_status_class.failed.converted_value).to eql('failed')
      expect(payment_status_class.failed.definition).to be(:failed)
      expect(payment_status_class.failed.enum_class).to eql(payment_status_class)
    end

    it 'defines singleton failed value method' do
      expect(payment_status_class.failed_value).to eql('failed')
    end

    it 'defines singleton failed value predicate method' do
      expect(payment_status_class.failed_value?('failed')).to be(true)
      expect(payment_status_class.failed_value?('invalid')).to be(false)
    end

    it 'defines singleton expired method' do
      expect(payment_status_class.expired).to be_a(SimpleEnumeration::Type)
      expect(payment_status_class.expired.value).to eql('expired')
      expect(payment_status_class.expired.converted_value).to eql('expired')
      expect(payment_status_class.expired.definition).to be(:expired)
      expect(payment_status_class.expired.enum_class).to eql(payment_status_class)
    end

    it 'defines singleton expired value method' do
      expect(payment_status_class.expired_value).to eql('expired')
    end

    it 'defines singleton expired value predicate method' do
      expect(payment_status_class.expired_value?('expired')).to be(true)
      expect(payment_status_class.expired_value?('invalid')).to be(false)
    end

    it 'defines singleton completed method' do
      expect(payment_status_class.completed).to be_a(SimpleEnumeration::Type)
      expect(payment_status_class.completed.value).to eql('completed')
      expect(payment_status_class.completed.converted_value).to eql('paid')
      expect(payment_status_class.completed.definition).to eql(completed: :paid)
      expect(payment_status_class.completed.enum_class).to eql(payment_status_class)
    end

    it 'defines singleton completed value method' do
      expect(payment_status_class.completed_value).to eql('paid')
    end

    it 'defines singleton completed value predicate method' do
      expect(payment_status_class.completed_value?('paid')).to be(true)
      expect(payment_status_class.completed_value?('completed')).to be(false)
      expect(payment_status_class.completed_value?('invalid')).to be(false)
    end

    it 'defines singleton basic collection method' do
      expect(payment_status_class.basic_collection).to be_a(SimpleEnumeration::Collection)
      expect(payment_status_class.basic_collection.types.values).to all(be_a(SimpleEnumeration::Type))
    end

    it 'defines singleton basic collection values method' do
      expect(payment_status_class.basic_collection_values).to eql(%w[unpaid failed expired paid])
    end

    it 'defines singleton basic collection value predicate method' do
      expect(payment_status_class.basic_collection_value?('unpaid')).to be(true)
      expect(payment_status_class.basic_collection_value?('failed')).to be(true)
      expect(payment_status_class.basic_collection_value?('expired')).to be(true)
      expect(payment_status_class.basic_collection_value?('paid')).to be(true)
      expect(payment_status_class.basic_collection_value?('completed')).to be(false)
      expect(payment_status_class.basic_collection_value?('invalid')).to be(false)
    end

    it 'defines singleton basic collection for select method' do
      expect(payment_status_class.basic_collection_for_select).to eql(
        [
          %w[Nieopłacone unpaid],
          ['Zakończone niepowodzeniem', 'failed'],
          %w[Wygasłe expired],
          %w[Zapłacone paid]
        ]
      )
    end

    it 'defines singleton basic collection humanized method' do
      expect(payment_status_class.basic_collection_humanized).to eql(
        ['Nieopłacone', 'Zakończone niepowodzeniem', 'Wygasłe', 'Zapłacone']
      )
    end

    it 'defines instance type method' do
      payment_status = payment_status_class.new(converted_value: 'paid')

      expect(payment_status.type).to be_a(SimpleEnumeration::Type)
      expect(payment_status.type.value).to eql('completed')
      expect(payment_status.type.converted_value).to eql('paid')
      expect(payment_status.type.definition).to eql(completed: :paid)
      expect(payment_status.type.enum_class).to eql(payment_status_class)
    end

    it 'defines instance unpaid value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'unpaid')

      expect(payment_status.unpaid_value?).to be(true)
    end

    it 'defines instance failed value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'failed')

      expect(payment_status.failed_value?).to be(true)
    end

    it 'defines instance expired value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'expired')

      expect(payment_status.expired_value?).to be(true)
    end

    it 'defines instance completed value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'paid')

      expect(payment_status.completed_value?).to be(true)

      payment_status = payment_status_class.new(converted_value: 'completed')

      expect(payment_status.completed_value?).to be(false)
    end

    it 'defines instance basic collection value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'expired')

      expect(payment_status.basic_collection_value?).to be(true)

      payment_status = payment_status_class.new(converted_value: 'completed')

      expect(payment_status.basic_collection_value?).to be(false)
    end
  end

  describe '.define_custom_collection' do
    subject(:payment_status_class) do
      Class.new(described_class) do
        def self.name
          'PaymentStatus'
        end

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

    it 'defines new singleton methods' do
      new_singleton_methods = payment_status_class.singleton_methods - Object.singleton_methods

      expect(new_singleton_methods).to match_array(
        %i[
          basic_collection
          failed
          basic_collection_values
          basic_collection_value?
          basic_collection_for_select
          basic_collection_humanized
          unpaid_value
          unpaid_value?
          failed_value
          failed_value?
          expired_value
          expired_value?
          completed_value
          completed_value?
          unpaid
          expired
          completed
          get_collection
          set_collection
          define_basic_collection
          define_custom_collection
          dry_initializer
          param
          option
          name
          finished_collection
          finished_collection_for_select
          finished_collection_humanized
          finished_collection_value?
          finished_collection_values
        ]
      )
    end

    it 'defines new instance methods' do
      new_instance_methods = payment_status_class.instance_methods - Object.instance_methods

      expect(new_instance_methods).to match_array(
        %i[
          failed_value?
          basic_collection_value?
          expired_value?
          completed_value?
          unpaid_value?
          type
          converted_value
          finished_collection_value?
        ]
      )
    end

    it 'defines singleton finished collection method' do
      expect(payment_status_class.finished_collection).to be_a(SimpleEnumeration::Collection)
      expect(payment_status_class.finished_collection.types.values).to all(be_a(SimpleEnumeration::Type))
    end

    it 'defines singleton finished collection values method' do
      expect(payment_status_class.finished_collection_values).to eql(%w[failed expired paid])
    end

    it 'defines singleton finished collection value predicate method' do
      expect(payment_status_class.finished_collection_value?('unpaid')).to be(false)
      expect(payment_status_class.finished_collection_value?('failed')).to be(true)
      expect(payment_status_class.finished_collection_value?('expired')).to be(true)
      expect(payment_status_class.finished_collection_value?('paid')).to be(true)
      expect(payment_status_class.finished_collection_value?('completed')).to be(false)
      expect(payment_status_class.finished_collection_value?('invalid')).to be(false)
    end

    it 'defines singleton finished collection for select method' do
      expect(payment_status_class.finished_collection_for_select).to eql(
        [
          ['Zakończone niepowodzeniem', 'failed'],
          %w[Wygasłe expired],
          %w[Zapłacone paid]
        ]
      )
    end

    it 'defines singleton finished collection humanized method' do
      expect(payment_status_class.finished_collection_humanized).to eql(
        ['Zakończone niepowodzeniem', 'Wygasłe', 'Zapłacone']
      )
    end

    it 'defines instance finished collection value predicate method' do
      payment_status = payment_status_class.new(converted_value: 'expired')

      expect(payment_status.finished_collection_value?).to be(true)

      payment_status = payment_status_class.new(converted_value: 'unpaid')

      expect(payment_status.finished_collection_value?).to be(false)

      payment_status = payment_status_class.new(converted_value: 'paid')

      expect(payment_status.finished_collection_value?).to be(true)

      payment_status = payment_status_class.new(converted_value: 'completed')

      expect(payment_status.finished_collection_value?).to be(false)
    end
  end
end
