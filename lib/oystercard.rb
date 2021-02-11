require_relative 'journey'

class Oystercard
  attr_reader :balance, :maximum_amount, :entry_station, :exit_station, :journey_list

  MAXIMUM_AMOUNT = 90
  Minimum_amount = 1
  Minimum_fare = 1

  def initialize(topup_limit = MAXIMUM_AMOUNT)
    @balance = 0
    @maximum_amount = topup_limit
    @journey_list = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "reached topup limit of #{maximum_amount}!" if @balance + amount > @maximum_amount

    @balance += amount
  end

  def touch_in(entry_station)
    raise "You have less than #{Minimum_amount} on your card" if @balance < Minimum_amount

    @journey = Journey.new(entry_station)

  end

  def touch_out(exit_station)
    @journey.end(exit_station)
    deduct(@journey.fare)
    @journey_list << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
  end
end

private

def deduct(amount)
  @balance -= amount
end
