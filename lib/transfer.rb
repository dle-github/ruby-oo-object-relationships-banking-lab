class Transfer
  attr_accessor :status
  attr_reader :receiver, :sender, :amount, :transferid
  @@transactions = Array.new

  def initialize(inputfrom, inputto, inputamount)
    @receiver = inputto
    @sender = inputfrom
    @amount = inputamount
    @status = "pending"
    @transferid = rand(10 ** 10).to_s.rjust(10,'0')  
  end

  def valid?
    @receiver.valid?
    @sender.valid?
  end
  
  def execute_transaction
    funds = @sender.balance
    @amount

    if @status == "pending" && @sender.valid? && @receiver.valid?
      p "status is [#{@status}], [#{@sender.name}]'s account is [#{@sender.valid?}], [#{@receiver.name}]'s account is [#{@receiver.valid?}]"    
      sleep 1
      if funds - @amount < 0
        @status = "rejected"
        p "Transaction rejected. Please check your account balance."
      else
        @sender.deposit(-@amount)
        p "subtract [#{@amount}] from [#{@sender.name}]'s account. [#{@sender.name}]'s balance is [#{@sender.balance}]"
        sleep 1
        @receiver.deposit(@amount)
        p "add [#{@amount}] to [#{@receiver.name}]'s account. [#{@receiver.name}]'s balance is [#{@sender.balance}]"
        sleep 1
        @@transactions << @transferid
        @status = "complete"
        
      end
    else
      @status = "rejected"
      p "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    funds = @receiver.balance
    if @@transactions.include?(@transferid)
      @receiver.deposit(-@amount)
      @sender.deposit(@amount)
      @status = "reversed"
    end
  end



end
