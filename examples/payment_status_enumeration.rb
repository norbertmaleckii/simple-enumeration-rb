# frozen_string_literal: true

class PaymentStatusEnumeration < SimpleEnumeration::Entity
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

  def self.convert_from_provider(string)
    case string
    when 'ERROR_1', 'ERROR_2'
      failed
    when 'TIMEOUT'
      expired
    when 'PAID'
      completed
    else
      unapid
    end
  end
end

class Order
  attr_accessor :payment_status

  def initialize(payment_status:)
    @payment_status = payment_status
  end

  def payment_status_enumeration
    @payment_status_enumeration ||= PaymentStatusEnumeration.new(
      converted_value: payment_status
    )
  end
end
