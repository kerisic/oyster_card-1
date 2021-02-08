class Oystercard
attr_reader :balance, :maximum_amount
MAXIMUM_AMOUNT = 90

  def initialize(topup_limit = MAXIMUM_AMOUNT)
    @balance = 0
    @maximum_amount = topup_limit
  end

  def top_up(amount)
    fail "reached topup limit of #{maximum_amount}!" if @balance + amount > @maximum_amount
    @balance += amount
  end

end
