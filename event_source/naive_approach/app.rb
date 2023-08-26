#! /usr/bin/env ruby



# This is a naive approach to the problem

# Scenario to model
# User pays for a coffee with a credit card
#    User Swipes card
#    Transaction is catologed in the system
#    General ledger is updated
#    Money is transfered from user to coffee shop

# The coffee shop needs the money immediately
# create transaction to the coffee shop a merchant within our system
# create transaction on the user balance
# create transaction on the general ledger
# validate the transaction
# if valid move the money
# if not valid, return the money

# initial state
# User has a balance of $10
# Coffee shop has a balance of $100 (this is the settlement value)
#
# end state:
# User has a balance of $5
# Coffee shop has a balance of $105
# General ledger has a record of the transaction

# User swipes card
class User
  def subscribe_to(topic)
    @subsciptions << [topic, 0]
  end

  attr_accessor :name, :credit_card
  def initialize(name, credit_card)
    @name = name
    @credit_card = credit_card
    @subsciptions = []
  end

  def poll
    @subsciptions.each do |topic, idx|
     next if topic[idx + 1].nil?

     topic[idx + 1].call
     topic[idx + 1] = nil
    end
  end
end

class CoffeeShop
  def initialize(name, balance_cents = 0)
    @name = name
    @balance_cents = balance_cents
  end
end

class CreditCard
  def initialize(card_number, balance_cents = 0)
    @card_number = card_number
    @balance_cents = balance_cents
  end
end

class BankAccount
  def initialize(balance_cents = 0)
    @balance_cents = balance_cents
  end
end

TRANSACTIONS_TOPIC=[]
class TransactionEvent
  def initialize(debit_account: , credit_account:, amount: )
    @debit_account = debit_account
    @credit_account = credit_account
    @amount = amount
  end

  def publish
    TRANSACTIONS_TOPIC << self
  end
end


CreditCard.subscribe_to(TRANSACTIONS_TOPIC)
CoffeeShop.subscribe_to(TRANSACTIONS_TOPIC)

user = User.new("John", CreditCard.new("1234-1234-1234-1234", 10_00) )
coffee_shop = CoffeeShop.new("Starbucks", 100_00)

TransactionEvent.new(debit_account: user.credit_card, credit_account: coffee_shop, amount: 5_00).publish



puts "User balance: #{user.credit_card.balance_cents}"
puts "Coffee shop balance: #{coffee_shop.balance_cents}"









