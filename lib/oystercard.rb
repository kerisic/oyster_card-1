class Oystercard
attr_reader :balance, :maximum_amount
MAXIMUM_AMOUNT = 90


  def initialize(topup_limit = MAXIMUM_AMOUNT)
    @balance = 0
    @maximum_amount = topup_limit
    @journey_status = false
  end

  def top_up(amount)
    fail "reached topup limit of #{maximum_amount}!" if @balance + amount > @maximum_amount
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end

  def in_journey?
    @journey_status
  end
end
