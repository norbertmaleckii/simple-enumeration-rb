# SimpleEnumeration

Enumerations system for Ruby with awesome features!

Helps you to declare enumerations in a very simple and flexible way. Define your enumerations in classes, it means you can add new behaviour and also reuse them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_enumeration'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simple_enumeration

## Usage

### Creating enumerations

Enumerations are defined as plain Ruby classes. For rails usage you can put definitions inside `app/enumerations` folder.

When we want define basic enumerations collection, we use `define_basic_collection` method like that:

```ruby
class PaymentStatusEnumeration < SimpleEnumeration::Entity
  define_basic_collection(
    :unpaid,
    :failed,
    :expired,
    completed: :paid
  )
end
```

After that we have new class and instance methods at our disposal:

* All enumeration's types have basic collection class methods:

  ```ruby
  PaymentStatusEnumeration.basic_collection
  #=> #<SimpleEnumeration::Collection:0x000000010d73ec78 @name=:basic,
  # @types={
  #  "unpaid"=>#<SimpleEnumeration::Type:0x000000010d733210 @converted_value="unpaid", @definition=:unpaid, @enum_class=PaymentStatusEnumeration, @value="unpaid">,
  #  "failed"=>#<SimpleEnumeration::Type:0x000000010d730358 @converted_value="failed", @definition=:failed, @enum_class=PaymentStatusEnumeration, @value="failed">,
  #  "expired"=>#<SimpleEnumeration::Type:0x000000010d726880 @converted_value="expired", @definition=:expired, @enum_class=PaymentStatusEnumeration, @value="expired">,
  #  "completed"=>#<SimpleEnumeration::Type:0x000000010d725570 @converted_value="paid", @definition={:completed=>:paid}, @enum_class=PaymentStatusEnumeration, @value="completed">
  #  }>

  PaymentStatusEnumeration.basic_collection_values
  #=> ["unpaid", "failed", "expired", "paid"]

  PaymentStatusEnumeration.basic_collection_value?('completed')
  #=> false

  PaymentStatusEnumeration.basic_collection_value?('paid')
  #=> true

  PaymentStatusEnumeration.basic_collection_for_select
  #=> [["Nieopłacone", "unpaid"], ["Zakończone niepowodzeniem", "failed"], ["Wygasłe", "expired"], ["Zapłacone", "paid"]]

  PaymentStatusEnumeration.basic_collection_humanized
  #=> ["Nieopłacone", "Zakończone niepowodzeniem", "Wygasłe", "Zapłacone"]
  ```

* Each enumeration's type has own class method:

  ```ruby
  PaymentStatusEnumeration.unpaid
  #=> #<SimpleEnumeration::Type:0x000000010d733210 @converted_value="unpaid", @definition=:unpaid, @enum_class=PaymentStatusEnumeration, @value="unpaid">

  PaymentStatusEnumeration.failed
  #=> #<SimpleEnumeration::Type:0x000000010d730358 @converted_value="failed", @definition=:failed, @enum_class=PaymentStatusEnumeration, @value="failed">

  PaymentStatusEnumeration.expired
  #=> #<SimpleEnumeration::Type:0x000000010d726880 @converted_value="expired", @definition=:expired, @enum_class=PaymentStatusEnumeration, @value="expired">

  PaymentStatusEnumeration.completed
  #=> #<SimpleEnumeration::Type:0x000000010d725570 @converted_value="paid", @definition={:completed=>:paid}, @enum_class=PaymentStatusEnumeration, @value="completed">

  PaymentStatusEnumeration.completed.definition
  # => :completed

  PaymentStatusEnumeration.completed.value
  #=> "completed"

  PaymentStatusEnumeration.completed.converted_value
  #=> "paid"

  PaymentStatusEnumeration.completed.for_select
  #=> ["Zapłacone", "paid"]

  PaymentStatusEnumeration.completed.humanized
  #=> "Zapłacone"

  PaymentStatusEnumeration.completed.meta
  #=> {:color=>"green"}

  PaymentStatusEnumeration.completed.translations
  #=> {:text=>"Zapłacone", :color=>"green"
  ```

When we want define custom enumerations collection, we use `define_custom_collection` method:

```ruby
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
end
```

After that we have all methods described above and new ones at our disposal:

```ruby
  PaymentStatusEnumeration.finished_collection
  #=> #<SimpleEnumeration::Collection:0x0000000109873bd8 @name=:finished,
  # @types={
  #  "failed"=>#<SimpleEnumeration::Type:0x000000010d730358 @converted_value="failed", @definition=:failed, @enum_class=PaymentStatusEnumeration, @value="failed">,
  #  "expired"=>#<SimpleEnumeration::Type:0x000000010d726880 @converted_value="expired", @definition=:expired, @enum_class=PaymentStatusEnumeration, @value="expired">,
  #  "completed"=>#<SimpleEnumeration::Type:0x000000010d725570 @converted_value="paid", @definition={:completed=>:paid}, @enum_class=PaymentStatusEnumeration, @value="completed">
  #  }>

  PaymentStatusEnumeration.finished_collection_values
  #=> ["failed", "expired", "paid"]

  PaymentStatusEnumeration.finished_collection_value?('completed')
  #=> false

  PaymentStatusEnumeration.finished_collection_value?('paid')
  #=> true

  PaymentStatusEnumeration.finished_collection_value?('unpaid')
  #=> false

  PaymentStatusEnumeration.finished_collection_for_select
  #=> [["Zakończone niepowodzeniem", "failed"], ["Wygasłe", "expired"], ["Zapłacone", "paid"]]

  PaymentStatusEnumeration.finished_collection_humanized
  #=> ["Zakończone niepowodzeniem", "Wygasłe", "Zapłacone"]
  ```


### Model definition

Initially, there is no special dsl extension, but we can simply do that:

```ruby
# ActiveRecord class
#
class Order < ApplicationRecord
  extend SimpleEnumeration::ObjectHelper

  define_simple_enumeration :payment_status
end

# Plain Ruby class
#
class Order
  extend SimpleEnumeration::ObjectHelper

  define_simple_enumeration :payment_status

  attr_accessor :payment_status

  def initialize(payment_status:)
    @payment_status = payment_status
  end
end
```

This will allow us to use enumeration type methods:

```ruby
order = Order.new(payment_status: 'paid')

order.payment_status_enumeration.type.humanized
#=> "Zapłacone"
order.payment_status_enumeration.type.meta
#=> {:color=>"green"}
order.payment_status_enumeration.type.translations
#=> {:text=>"Zapłacone", :color=>"green"}
order.payment_status_enumeration.type.for_select
#=> ["Zapłacone", "paid"]

order.payment_status_enumeration.unpaid_value?
#=> false
order.payment_status_enumeration.failed_value?
#=> false
order.payment_status_enumeration.expired_value?
#=> false
order.payment_status_enumeration.completed_value?
#=> true
order.payment_status_enumeration.basic_collection_value?
#=> true
order.payment_status_enumeration.finished_collection_value?
#=> true
```

### Translations

Translations are defined using i18n gem.

#### I18n lokup

The I18n strings are located on `simple_enumeration.<enumeration_name>.<value>.text`:

```yaml
pl:
  simple_enumeration:
    payment_status:
      unpaid:
        text: "Nieopłacone"
        color: yellow
```

#### Translate a name-spaced enumeration

In order to translate an enumeration in a specific namespace (say `Payments::StatusEnumeration`),
you can add the following:

```yaml
pl:
  simple_enumeration:
    payments/status:
      unpaid:
        text: "Nieopłacone"
        color: yellow
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/norbertmaleckii/simple-enumeration-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/norbertmaleckii/simple-enumeration-rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Enumeration project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/norbertmaleckii/simple-enumeration-rb/blob/main/CODE_OF_CONDUCT.md).
