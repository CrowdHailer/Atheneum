# Atheneum
> *noun* **place where records are stored**



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atheneum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atheneum

## Usage
### Basic

You have a user record, it's always a user, that has a password. There is a `crypted_password` field on your model from the database. Atheneum can use the crypt strategy to take care of storing and retrieving the password. It will also privatise the original attribute accessors so the objects public interface is only the new attribute accessors.

**NB: you must also include bcrypt in your gems for this example**

```rb
class UserRecord < Struct.new(:crypted_password)
  include Atheneum.crypt(:password)
end

user_record = UserRecord.new
user_record.password = 'password'
puts user
# => #<struct UserRecord crypted_password="$2a$10$0lScjOJwCUVdtqGrtIgww.RbvVWXGPD.oISi4DBcIgK3f3YO66aju">

user_record.password == 'password'
# => true

user_record.crypted_password
# => NoMethodError: private method `crypted_password' called for #<UserRecord:0x0000000236f9f0>


# Without Atheneum
class UserRecord < Struct.new(:crypted_password)
  def password=(password)
    self.crypted_password = BCrypt::Password.create(password).to_s
  end

  def password
    BCrypt::Password.new(crypted_password)
  end

  private :crypted_password, :crypted_password=
end
```
### Options

Storage methods accept more than one attribute. They also take an optional configuration hash

- **privatise** *(default: true)* Sets whether existing accessors should privatised

- **prefix** Overwrites the strategies default prefix

  Strategies with no default prefix will use the strategies name eg `SomeStrategy` => `some_strategy`

### New Storage Strategy

Say you wanted some strings to be reversed before adding to the database. Perhaps exceptionally mild security.

Atheneum looks up strategy classes namespaced under `Atheneum::Strategy`. These need to implement a pack and unpack method as well as optionally generating the storage location

```rb
module Atheneum
  class Strategy
    class Reverse < Base

      def pack(item)
        item.reverse
      end

      def unpack(item)
        item.reverse
      end

    end
  end
end

class LocationRecord < Struct.new(:obscured_address, :obscured_name)
  include Atheneum.reverse :address, :name, :prefix => 'obscured', :privatise => false
end

location_record = LocationRecord.new

location_record.name = 'office'

location_record.obscured_name
# => "eciffo"
```

#### Immaculate Record

An immaculate record is one that acts purely as a data structure. In practise this works for all classes that can be proxied with a Struct/OpenStruct

#### Password exmaple

## Contributing

1. Fork it ( https://github.com/[my-github-username]/atheneum/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
