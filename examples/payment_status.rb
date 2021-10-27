# frozen_string_literal: true

require 'simple_enumeration'

class PaymentStatus < SimpleEnumeration::Entity
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
