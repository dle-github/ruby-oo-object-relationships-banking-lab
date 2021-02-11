class BankAccount
    attr_accessor :balance, :status
    attr_reader :name
    @@all_accounts = Array.new

    def initialize(input)
        @name = input
        @balance = 1000
        @status = "open"
        ##################
        @@all_accounts << self
    end

    def deposit(input)
        @balance += input
    end

    def display_balance
        p "Your balance is $#{@balance}."
    end

    def valid?
        @status == "open" && @balance > 0? true : false
    end

    def close_account
        @balance = 0
        @status = "closed"
    end
end
