#! /usr/bin/env ruby


class User
    @@users = {}

    def self.find_by_id(id)
      @@users[id]
    end

    attr_accessor :name, :address_id
    def initialize(id, name, address_id)
      @id = id
      @name = name
      @address_id = address_id
    end

    def address
      Address.find_by_id(@address_id)
    end

    def save
      @@users[@id] = self
    end
end

class Address
    @@addresses={}

    def self.find_by_id(id)
      @@addresses[id]
    end

    attr_accessor :street, :city, :state, :zip
    def initialize(id, street, city, state, zip)
      @id = id
      @street = street
      @city = city
      @state = state
      @zip = zip
    end

    def save
      @@addresses[@id] = self
    end
end

user = User.new(1, "John", nil)
user.save

address = Address.new(1, "123 Main St", "San Francisco", "CA", "94105")
address.save

class Result
    def initialize(value)
      @value = value
    end

    def and_then(&block)
      block.call(@value)
    end

    class Success
    end

    class Failure
    end
end


def associate_user(user_id, address_id)
    user = User.find_by_id(user_id)
    if user.nil?
      raise "User not found"
    end

    address = Address.find_by_id(address_id)
    if address.nil?
      raise "Address not found"
    end

    user.address_id = address_id
    user.save
end

associate_user(1, 1)

puts "User address: #{user.address.street}"