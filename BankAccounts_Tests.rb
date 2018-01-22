require "./BankAccounts_LiubyshOlha.rb"
require 'rspec'

describe BankAccount do
    before(:each) do
        @debitAccount = DebitAccount.new(10000)
        @currentAccount = CurrentAccount.new(100)
        @creditAccount = CreditAccount.new(0)
    end
 
    it 'Check debit balance' do
        expect(@debitAccount.balance).to eq 10000
    end

    it 'Check current balance' do
        expect(@currentAccount.balance).to eq 100
    end

    it 'Check credit balance' do
        expect(@creditAccount.balance).to eq 0
    end
    
    it 'Check withDrawal for debit' do
        expect(@debitAccount.withDrawal(10)).to eq true
        expect(@debitAccount.balance).to eq 9990
    end

    it 'Check withDrawal for current' do
        expect(@currentAccount.withDrawal(100)).to eq true
        expect(@currentAccount.balance).to eq 0
    end

    it 'Check withDrawal for credit' do
        expect(@creditAccount.withDrawal(100)).to eq true
        expect(@creditAccount.balance).to eq -100
    end

    it 'Check withDrawal with non-integer amount' do
        expect{@debitAccount.withDrawal("qwe")}.to raise_exception(ArgumentError)
        expect(@debitAccount.checkBalance).to eq 10000
    end

    it 'Check withDrawal with non-positive amount' do
        expect(@creditAccount.withDrawal(-1)).to eq false
        expect(@creditAccount.checkBalance).to eq 0
    end
    
    it 'Check withDrawal with more than available amount' do
        expect(@creditAccount.withDrawal(1001)).to eq false
        expect(@creditAccount.checkBalance).to eq 0
    end

    it 'Check transfer with non-integer amount' do
        expect{@debitAccount.transferToCurrent("qwe", @currentAccount)}.to raise_exception(ArgumentError)
        expect(@debitAccount.checkBalance).to eq 10000
        expect(@currentAccount.checkBalance).to eq 100
    end
    
    it 'Check transfer from debit to current' do
        expect(@debitAccount.transferToCurrent(1000, @currentAccount)).to eq true
        expect(@debitAccount.balance).to eq 9000
        expect(@currentAccount.balance).to eq 1100
    end

    it 'Check transfer with non-positive amount' do
        expect(@debitAccount.transferToCurrent(-1, @currentAccount)).to eq false
        expect(@debitAccount.checkBalance).to eq 10000
        expect(@currentAccount.checkBalance).to eq 100
    end
    
    it 'Check transfer with more than available amount' do
        expect(@debitAccount.transferToCurrent(10001, @currentAccount)).to eq false
        expect(@debitAccount.checkBalance).to eq 10000
        expect(@currentAccount.checkBalance).to eq 100
    end
end
