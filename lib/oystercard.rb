require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :maximum_amount, :entry_station, :exit_station, :journey_list

  MAXIMUM_AMOUNT = 90
  Minimum_amount = 1
  Minimum_fare = 1

  def initialize(topup_limit = MAXIMUM_AMOUNT, journey_log = JourneyLog.new, _balance = 0)
    @balance = 0
    @maximum_amount = topup_limit
    @journey_list = []
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "reached topup limit of #{maximum_amount}!" if @balance + amount > @maximum_amount

    @balance += amount
  end

  def touch_in(entry_station)
    raise "You have less than #{Minimum_amount} on your card" if @balance < Minimum_amount

    deduct @journey_log.journeys.last.fare if @journey_log.in_journey?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys.last.fare)
  end

  def journey_history
    @journey_log.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
