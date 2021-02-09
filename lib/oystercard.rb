class Oystercard
attr_reader :balance, :maximum_amount
MAXIMUM_AMOUNT = 90
Minimum_amount = 1
Minimum_fare = 1


  def initialize(topup_limit = MAXIMUM_AMOUNT)
    @balance = 0
    @maximum_amount = topup_limit
    @journey_status = false
  end

  def top_up(amount)
    fail "reached topup limit of #{maximum_amount}!" if @balance + amount > @maximum_amount
    @balance += amount
  end

  def touch_in(entry_station)
    fail "You have less than #{Minimum_amount} on your card" if @balance < Minimum_amount
    @journey_status = true
  end

  def touch_out
    deduct(Minimum_fare)
    @journey_status = false
  end

  def in_journey?
    @journey_status
  end
end

private
def deduct(amount)
  @balance -= amount
end


#test test test
