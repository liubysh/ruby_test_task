class BankAccount
    attr_reader :balance
    def initialize(balance, minBalance)
        if(balance.to_i)
            @balance = balance
        else
            raise ArgumentError, "You've entered non-integer value."
        end
        @minBalance = minBalance
    end
    
    def checkBalance
        puts "Your account balance is $#{@balance}."
        return @balance
    end
    
    def withDrawal(amountToTransfer)
        if(amountToTransfer.to_i)
            if(amountToTransfer < 1)
                puts "Transfer was not completed. Amount should be greater or equal to $1."
                return false
            elsif(@balance - amountToTransfer >= @minBalance)
                @balance -= amountToTransfer
                puts "Transfer was successfully completed. You've transfered #{amountToTransfer}. Your account balance is $#{@balance}."
                return true
            else
                puts "Transfer was not completed. You are trying to transfer/withdrawal more then available on account."
                return false
            end
        else
            raise ArgumentError, "You've entered non-integer value."
        end
    end
end

class CurrentAccount < BankAccount
    def initialize(balance)
        if(balance>=0)
            super(balance, 0)
        else
            raise ArgumentError, "You've entered negative value for current account balance, but it shoult be non-negative. "
        end
    end
    
    def receive(amount)
        @balance += amount
    end
end

class DebitAccount < BankAccount
    def initialize(balance)
        if(balance>=0)
            super(balance, 0)
        else
            raise ArgumentError, "You've entered negative value for debit account balance, but it shoult be non-negative. "
        end
    end
    
    def transferToCurrent(amount, currentAccount)
        if(self.withDrawal(amount))
            currentAccount.receive(amount)
            return true
        else
            return false
        end
    end
end

class CreditAccount < BankAccount
    def initialize(balance)
        if(balance<=0)
            super(balance, -1000)
        else
            raise ArgumentError, "You've entered positive value for credit account balance, but it shoult be non-positive. "
        end
    end
end


def main
    debitAccount = DebitAccount.new(10000)
    currentAccount = CurrentAccount.new(100)
    creditAccount = CreditAccount.new(0)

    debitAccount.withDrawal(500)
    currentAccount.withDrawal(10)
    creditAccount.withDrawal(500)

    debitAccount.checkBalance
    currentAccount.checkBalance
    creditAccount.checkBalance

    debitAccount.transferToCurrent(1000, currentAccount)
    currentAccount.checkBalance

    debitAccount.transferToCurrent(10000, currentAccount)
    currentAccount.checkBalance
end

main